module CassClient
  # Connection module

  module Connection
    require 'uri'

    DEFAULT_URL     = 'www.example.com'.freeze
    DEFAULT_VERSION = '/api'.freeze

    def setup_connection(p = {})
      @host  = p[:host] || DEFAULT_URL
      @token = p[:token]
    end

    def headers
      {
        'Token' => @token
      }
    end

    def base_url
      URI.parse(@host).to_s
    end
  end

end