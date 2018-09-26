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

      req_options = {
        :use_ssl => uri.scheme == "https",
      }

      res = Net::HTTP.start(uri.host, uri.port, req_options) { |http|
        http.request(req)
       }
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
