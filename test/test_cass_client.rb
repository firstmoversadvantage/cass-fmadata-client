require 'minitest/autorun'
require 'minitest/spec'
require 'dotenv'
Dotenv.load
require 'cass_fmadata_client'
require 'pry'
require 'webmock/minitest'
WebMock.disable_net_connect!

class CassClientTest < Minitest::Test

  def test_initialize_cass_client
    CassFma::Client.new(host:  ENV['CASS_URL'],
                        token: ENV['CASS_TOKEN'])
  end

  def test_tiger_method
    client = test_initialize_cass_client

    params =  { "city": "Boulder",
                "state": "CO",
                "street_address": "2950 N Lakeridge Trl",
                "zip": "80302" }

    stub_request(:get, ENV['CASS_URL'] + 'tiger/?city=Boulder&state=CO&street_address=2950+N+Lakeridge+Trl&zip=80302').
      with(headers: {'Accept':          '*/*',
                     'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Token':           ENV['CASS_TOKEN'],
                     'User-Agent':      'Ruby'}).
      to_return(status: 200, body: "", headers: {})

    response = client.tiger(params)
    assert_equal response.code, '200'
  end

  def test_city_county_method
    client = test_initialize_cass_client

    params =  { "zip" => "80302" }

    stub_request(:get, ENV['CASS_URL'] + 'city-county/?zip=80302').
      with(headers: {'Accept':          '*/*',
                     'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Token':           ENV['CASS_TOKEN'],
                     'User-Agent':      'Ruby'}).
      to_return(status: 200, body: "", headers: {})

    response = client.city_county(params)
    assert_equal response.code, '200'
  end

  def test_search_by_address_method
    client = test_initialize_cass_client

    params =  { "city" => "Boulder",
                "state" => "CO",
                "street_address" => "2950 N Lakeridge Trl",
                "zip" => "80302" }

    stub_request(:get, ENV['CASS_URL'] + 'search-by-address/?city=Boulder&state=CO&street_address=2950+N+Lakeridge+Trl&zip=80302').
      with(headers: {'Accept':          '*/*',
                     'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Token':           ENV['CASS_TOKEN'],
                     'User-Agent':      'Ruby'}).
      to_return(status: 200, body: "", headers: {})

    response = client.search_by_address(params)
    
    assert_equal response.code, '200'
  end

  def test_state_county_method
    client = test_initialize_cass_client

    params =  { "state" => "CO" }

    stub_request(:get, ENV['CASS_URL'] + 'state-county/?state=CO').
      with(headers: {'Accept':          '*/*',
                     'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Token':           ENV['CASS_TOKEN'],
                     'User-Agent':      'Ruby'}).
      to_return(status: 200, body: "", headers: {})

    response = client.state_county(params)
    assert_equal response.code, '200'
  end

  def test_city_zip_method
    client = test_initialize_cass_client

    params =  { "city" => "Boulder",
                "state" => "CO" }

    stub_request(:get, ENV['CASS_URL'] + 'city-zip/?city=Boulder&state=CO').
      with(headers: {'Accept':          '*/*',
                     'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Token':           ENV['CASS_TOKEN'],
                     'User-Agent':      'Ruby'}).
      to_return(status: 200, body: "", headers: {})

    response = client.city_zip(params)
    assert_equal response.code, '200'
  end

  def test_address_method
    client = test_initialize_cass_client

    params =  { "city": "Boulder",
                "state": "CO",
                "street_address": "2950 N Lakeridge Trl",
                "zip": "80302" }

    stub_request(:get, ENV['CASS_URL'] + 'address/?city=Boulder&state=CO&street_address=2950+N+Lakeridge+Trl&zip=80302').
      with(headers: {'Accept':          '*/*',
                     'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Token':           ENV['CASS_TOKEN'],
                     'User-Agent':      'Ruby'}).
      to_return(status: 200, body: "", headers: {})
        
    response = client.address(params)

    assert_equal response.code, '200'
  end

  def test_retry_logic_service_unavailable
    client = CassFma::Client.new(host:  ENV['CASS_URL'],
                                 token: ENV['CASS_TOKEN'],
                                 max_retries: 3,
                                 retry_interval: 1)

    params =  { "city": "Boulder",
                "state": "CO",
                "street_address": "2950 N Lakeridge Trl",
                "zip": "80302" }

    stub_request(:get, ENV['CASS_URL'] + 'address/?city=Boulder&state=CO&street_address=2950+N+Lakeridge+Trl&zip=80302').
      with(headers: {'Accept':          '*/*',
                     'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Token':           ENV['CASS_TOKEN'],
                     'User-Agent':      'Ruby'}).
      to_return(status: 503, body: "", headers: {})

    error = assert_raises CassFma::BadResponseError do
      client.address(params)
    end

    assert_equal 'Net::HTTPServiceUnavailable (MAX_RETRIES reached)', error.message
  end


  def test_retry_logic_bad_gateway
    client = CassFma::Client.new(host:  ENV['CASS_URL'],
                                 token: ENV['CASS_TOKEN'],
                                 max_retries: 3,
                                 retry_interval: 1)

    params =  { "city": "Boulder",
                "state": "CO",
                "street_address": "2950 N Lakeridge Trl",
                "zip": "80302" }

    stub_request(:get, ENV['CASS_URL'] + 'address/?city=Boulder&state=CO&street_address=2950+N+Lakeridge+Trl&zip=80302').
      with(headers: {'Accept':          '*/*',
                     'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Token':           ENV['CASS_TOKEN'],
                     'User-Agent':      'Ruby'}).
      to_return(status: 502, body: "Bad Gateway", headers: {})

    error = assert_raises CassFma::BadResponseError do
      client.address(params)
    end

    assert_equal 'Net::HTTPBadGateway (MAX_RETRIES reached)', error.message
  end
end
