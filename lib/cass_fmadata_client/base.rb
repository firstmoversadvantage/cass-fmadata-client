module CassClient
  class Base
    include Connection
    include Loggable

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

    def zip_city_state(p = {})
      send_request(p, zip_city_state_url)
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

      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end
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

    def zip_city_state_url
      @host + 'zip-city-state/'
    end
  end
end