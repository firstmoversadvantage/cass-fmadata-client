require 'minitest/autorun'
require 'cass_fmadata_client'
require 'pry'
require 'dotenv/load'

class CassClientTest < Minitest::Test
  def test_initialize_cass_slient
    Cass::Client.new(host:  ENV['CASS_URL'],
                     token: ENV['CASS_TOKEN'])
  end

  def test_tiger_method
    client = test_initialize_cass_slient

    params =  { "city" => "Boulder",
                "state" => "CO",
                "street_address" => "2950 N Lakeridge Trl",
                "zip" => "80302" }

    response = client.tiger(params)
    assert_equal response.code, '200'
    assert_equal JSON.parse(response.body)['search_key'], "80302931050"
  end

  def test_city_county_method
    client = test_initialize_cass_slient

    params =  { "zip" => "80302" }

    response = client.city_county(params)
    assert_equal response.code, '200'
    assert_equal JSON.parse(response.body)['city'], "BOULDER                     "
    assert_equal JSON.parse(response.body)['state'], "CO"
    assert_equal JSON.parse(response.body)['countyname'], "BOULDER                  "
    assert_equal JSON.parse(response.body)['countynum'], "013"
  end

  def test_search_by_address_method
    client = test_initialize_cass_slient

    params =  { "city" => "Boulder",
                "state" => "CO",
                "street_address" => "2950 N Lakeridge Trl",
                "zip" => "80302" }

    response = client.search_by_address(params)
    assert_equal response.code, '200'
    assert_equal JSON.parse(response.body)['city'], "Boulder"
    assert_equal JSON.parse(response.body)['state'], "CO "
    assert_equal JSON.parse(response.body)['county_name'], "Boulder"
    assert_equal JSON.parse(response.body)['county_number'], "013 "
  end

  def test_state_county_method
    client = test_initialize_cass_slient

    params =  { "state" => "CO" }

    response = client.state_county(params)
    assert_equal response.code, '200'
    assert_equal JSON.parse(response.body)['county_names'].count, 64
  end

  def test_zip_city_state_method
    client = test_initialize_cass_slient

    params =  { "city" => "Boulder",
                "state" => "CO" }

    response = client.zip_city_state(params)
    assert_equal response.code, '200'
    assert_equal JSON.parse(response.body)['zip'].count, 11
  end
end
