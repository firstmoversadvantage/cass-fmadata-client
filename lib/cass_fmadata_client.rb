require 'cass_fmadata_client/connection'
require 'cass_fmadata_client/base'
# require 'dotenv/load'
require 'net/http'
require 'json'

module CassFma
  class Client < CassClient::Base; end
end