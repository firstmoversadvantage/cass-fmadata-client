# cass-fmadata-client
Public Ruby gem for cass.fmadata.com

This gem is a client library for [cass.fmadata.com](cass.fmadata.com) API

# Usage

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cass-fmadata-client', '0.0.1', git: 'git://github.com/firstmoversadvantage/cass-fmadata-client.git',
                              branch: 'stage-client'
```

For Ruby 1.8.7:
```ruby
gem 'cass-fmadata-client', '0.0.5',
                           :git => 'git://github.com/firstmoversadvantage/cass-fmadata-client.git',
                           :branch => '1.8-version'
```

From your application set up connection:

```ruby
require 'cass_fmadata_client'

cass = Casss::Client.new(host:  host,
                         token: token)
```

# Usage

## Tiger method

```ruby
response = cass.tiger params

parsed_response = JSON.parse(response.body)
```

### Example

```ruby
response = cass.tiger(street_address: '1035 Pearl St Ste 323',
                      city: 'Boulder',
                      state: 'CO',
                      zip: '80302')

JSON.parse(response.body) => {"address_type"=>"H",
                              "census_block"=>"3035",
                              "census_tract"=>"012204",
                              "street_address"=>"1035 Pearl St # 323",
                              "city"=>"Boulder",
                              "state"=>"CO",
                              "zip_9"=>"80302-5130",
                              "search_key"=>"80302513099#323",
                              "county_name"=>"Boulder",
                              "county_number"=>"013",
                              "fips"=>"08013",
                              "latitude"=>40.017487,
                              "longitude"=>-105.281952,
                              "return_code"=>"1",
                              "dpbc"=>"99",
                              "dpv_confirmation_indicator"=>"S",
                              "in_city"=>"Boulder",
                              "in_state"=>"CO",
                              "in_street_address"=>"1035 pearl st # 323",
                              "in_zip"=>"80302",
                              "post_directional"=>"",
                              "pre_directional"=>"",
                              "state_number"=>"08",
                              "street_name"=>"PEARL",
                              "street_number"=>"1035",
                              "street_suffix"=>"ST",
                              "unit_number"=>"323",
                              "unit_type"=>"#",
                              "zip_4"=>"5130",
                              "zip_5"=>"80302"}
```

## City County method

```ruby
response = cass.city_county params

parsed_response = JSON.parse(response.body)
```

### Example

```ruby
response = cass.city_county(zip: "80302")

JSON.parse(response.body) => {"city"=>"BOULDER",
                              "state"=>"CO",
                              "zip"=>"80302",
                              "county_name"=>"BOULDER",
                              "county_number"=>"013",
                              "return_code"=>"0"}
```

## Contributing
Contact: http://www.firstmoversadvantage.com

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).