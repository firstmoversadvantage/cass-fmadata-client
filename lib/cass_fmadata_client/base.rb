module CassClient
  class Base
    include Connection

    def initialize(p={})
      setup_connection(p)
    end

    def tiger(p = {})
      send_request(p, tiger_url)
    end

    def city_county(p = {})
      send_request(p, city_county_url)
    end

    def search_by_address(p = {})
      send_request(p, search_by_address_url)
    end

    def state_county(p = {})
      send_request(p, state_county_url)
    end

    def city_zip(p = {})
      send_request(p, city_zip_url)
    end

    def address(p = {})
      send_request(p, address_url)
    end

    private

    def send_request(p, url)
      uri = URI.parse(url)

      query_url = "#{uri.path}?".concat(p.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))
      req = Net::HTTP::Get.new(query_url)
      req["Token"] = @token

      try_number = 0
      begin
        start(uri.host, uri.port, :use_ssl => true) do |http|
          response = http.request(req)

          # raise error if the response is other than Success
          raise CassFma::BadResponseError, response.class.name unless response.kind_of? Net::HTTPSuccess
          response
        end
      rescue CassFma::BadResponseError => e
        try_number += 1

        # raise an error if max retries reached - it's neccessary to inform a client that there are still some issue
        raise update_error_message(e) and return if try_number > @max_retries
        sleep @retry_interval
        retry
      end
    end

    def start(address, *arg, &block) # :yield: +http+
      arg.pop if opt = Hash.try_convert(arg[-1])
      port, p_addr, p_port, p_user, p_pass = *arg
      port = https_default_port if !port && opt && opt[:use_ssl]
      http = Net::HTTP.new(address, port, p_addr, p_port, p_user, p_pass)

      if opt
        http.cert_store = OpenSSL::X509::Store.new.tap { |store| store.set_default_paths }

        # opt = {verify_mode: OpenSSL::SSL::VERIFY_PEER}.update(opt) if opt[:use_ssl]
        http.methods.grep(/\A(\w+)=\z/) do |meth|
          key = $1.to_sym
          opt.key?(key) or next
          http.__send__(meth, opt[key])
        end
      end

      http.start(&block)
    end

    # Add some more specific info to error message
    def update_error_message(e)
      e.message << ' (MAX_RETRIES reached)'
      e
    end

    def tiger_url
      @host + 'tiger/'
    end

    def city_county_url
      @host + 'city-county/'
    end

    def search_by_address_url
      @host + 'search-by-address/'
    end

    def state_county_url
      @host + 'state-county/'
    end

    def city_zip_url
      @host + 'city-zip/'
    end

    def address_url
      @host + 'address/'
    end
  end
end
