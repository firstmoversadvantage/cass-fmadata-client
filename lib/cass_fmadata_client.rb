require_relative 'cass_fmadata_client/connection'
require_relative 'cass_fmadata_client/base'
require 'dotenv/load'
require 'net/http'
require 'json'

module CassFma
  class Client < CassClient::Base; end
  class BadResponseError < StandardError; end
end
