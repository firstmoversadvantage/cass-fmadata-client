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

    def prepare_url(p, url)
      uri = URI.parse(url)

      #Add params to URI
      uri.query = URI.encode_www_form(p)
      uri
    end

    def send_request(p, url)
      uri = prepare_url(p, url)

      request = Net::HTTP::Get.new(uri)
      request["Token"] = @token

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      # set try_number for retry logic
      try_number = 0
      begin
        Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          response = http.request(request)

          # raise error if the response is other than Success
          raise CassFma::BadResponseError, response.class.name unless response.kind_of? Net::HTTPSuccess
          response
        end
      rescue CassFma::BadResponseError => e
        try_number += 1

        # raise an error if max retries reached - it's neccessary to inform a client that there
        # still is some issue with the service
        raise(e, custom_error_message(e)) if try_number > @max_retries

        sleep @retry_interval
        retry
      end
    end

    # Add some more specifically info to error message
    def custom_error_message(e)
      "#{e.message} (MAX_RETRIES reached)"
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
