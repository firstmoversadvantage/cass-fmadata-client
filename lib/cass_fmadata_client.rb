require_relative 'cass_fmadata_client/connection'
require_relative 'cass_fmadata_client/loggable'
require_relative 'cass_fmadata_client/base'
require 'dotenv/load'
require 'net/http'
require 'json'

module Casss
  class Client < CassClient::Base; end
end