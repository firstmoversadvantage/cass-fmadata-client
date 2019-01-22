module CassClient
  # Connection module

  module Connection
    require 'uri'

    DEFAULT_URL     = 'www.example.com'.freeze
    DEFAULT_VERSION = '/api'.freeze
    # retry logic defaults:
    DEFAULT_MAX_RETRIES = 5
    # retry interval in seconds
    DEFAULT_RETRY_INTERVAL = 3

    def setup_connection(p = {})
      @host           = p[:host]            || DEFAULT_URL
      @token          = p[:token]
      @max_retries    = p[:max_retries]     || DEFAULT_MAX_RETRIES
      @retry_interval = p[:retry_interval]  || DEFAULT_RETRY_INTERVAL
    end

    def headers
      {
        'Token': @token
      }
    end

    def base_url
      URI.parse(@host).to_s
    end
  end
end
