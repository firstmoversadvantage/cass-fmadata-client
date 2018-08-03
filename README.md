# cass-fmadata-client
Public Ruby gem for cass.fmadata.com

This gem is a client library for [cass.fmadata.com](cass.fmadata.com) API

# Usage

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cass-fmadata-client', '1.0.0', git: 'git://github.com/firstmoversadvantage/cass-fmadata-client.git'
```

For Ruby 1.8.7:
```ruby
gem 'cass-fmadata-client', '1.0.0',
                           :git => 'git://github.com/firstmoversadvantage/cass-fmadata-client.git',
                           :branch => '1.8-version'
```

From your application set up connection:

```ruby
require 'cass_fmadata_client'

cass = CassFma::Client.new(host:  host,
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

## Search by Address method

```ruby
response = cass.search_by_address params

parsed_response = JSON.parse(response.body)
```

### Example

```ruby
response = cass.search_by_address(street_address: '1035 Pearl St Ste 323',
                                  city: 'Boulder',
                                  state: 'CO',
                                  zip: '80302')

JSON.parse(response.body) => {"street_address"=>"1035 Pearl St # 323",
                              "city"=>"Boulder",
                              "state"=>"CO",
                              "zip_9"=>"80302-5130",
                              "search_key"=>"80302513099#323",
                              "county_name"=>"Boulder",
                              "county_number"=>"013",
                              "fips"=>"08013",
                              "return_code"=>"1"}
```

## State County method

```ruby
response = cass.state_county params

parsed_response = JSON.parse(response.body)
```

### Example

```ruby
response = cass.state_county(state: 'CO')

JSON.parse(response.body) => {"county_names"=>{"001"=>"ADAMS",
                                               "003"=>"ALAMOSA",
                                               "005"=>"ARAPAHOE",
                                               "007"=>"ARCHULETA",
                                               "009"=>"BACA",
                                               "011"=>"BENT",
                                               "013"=>"BOULDER",
                                               "014"=>"BROOMFIELD",
                                               "015"=>"CHAFFEE",
                                               "017"=>"CHEYENNE",
                                               "019"=>"CLEAR CREEK",
                                               "021"=>"CONEJOS",
                                               "023"=>"COSTILLA",
                                               "025"=>"CROWLEY",
                                               "027"=>"CUSTER",
                                               "029"=>"DELTA",
                                               "031"=>"DENVER",
                                               "033"=>"DOLORES",
                                               "035"=>"DOUGLAS",
                                               "037"=>"EAGLE",
                                               "039"=>"ELBERT",
                                               "041"=>"EL PASO",
                                               "043"=>"FREMONT",
                                               "045"=>"GARFIELD",
                                               "047"=>"GILPIN",
                                               "049"=>"GRAND",
                                               "051"=>"GUNNISON",
                                               "053"=>"HINSDALE",
                                               "055"=>"HUERFANO",
                                               "057"=>"JACKSON",
                                               "059"=>"JEFFERSON",
                                               "061"=>"KIOWA",
                                               "063"=>"KIT CARSON",
                                               "065"=>"LAKE",
                                               "067"=>"LA PLATA",
                                               "069"=>"LARIMER",
                                               "071"=>"LAS ANIMAS",
                                               "073"=>"LINCOLN",
                                               "075"=>"LOGAN",
                                               "077"=>"MESA",
                                               "079"=>"MINERAL",
                                               "081"=>"MOFFAT",
                                               "083"=>"MONTEZUMA",
                                               "085"=>"MONTROSE",
                                               "087"=>"MORGAN",
                                               "089"=>"OTERO",
                                               "091"=>"OURAY",
                                               "093"=>"PARK",
                                               "095"=>"PHILLIPS",
                                               "097"=>"PITKIN",
                                               "099"=>"PROWERS",
                                               "101"=>"PUEBLO",
                                               "103"=>"RIO BLANCO",
                                               "105"=>"RIO GRANDE",
                                               "107"=>"ROUTT",
                                               "109"=>"SAGUACHE",
                                               "111"=>"SAN JUAN",
                                               "113"=>"SAN MIGUEL",
                                               "115"=>"SEDGWICK",
                                               "117"=>"SUMMIT",
                                               "119"=>"TELLER",
                                               "121"=>"WASHINGTON",
                                               "123"=>"WELD",
                                               "125"=>"YUMA"}}

```

## Zip City State method

```ruby
response = cass.zip_city_state params

parsed_response = JSON.parse(response.body)
```

### Example

```ruby
response = cass.zip_city_state(city: 'Boulder',
                               state: 'CO')

JSON.parse(response.body) => { "zip"=> ["80301",
                                        "80302",
                                        "80303",
                                        "80304",
                                        "80305",
                                        "80306",
                                        "80307",
                                        "80308",
                                        "80309",
                                        "80310",
                                        "80314"] }
```

## Address method

```ruby
response = cass.address params

parsed_response = JSON.parse(response.body)
```

### Example

```ruby
response = cass.address(street_address: '1035 Pearl St Ste 323',
                        city: 'Boulder',
                        state: 'CO',
                        zip: '80302')

JSON.parse(response.body) => { "street_suffix"=>"TRL",
                               "fips"=>"08013",
                               "in_state"=>"CO",
                               "state"=>"CO",
                               "unit_type"=>"",
                               "street_number"=>"2950",
                               "county_name"=>"Boulder",
                               "dpv_confirmation_indicator"=>"Y",
                               "return_code"=>1,
                               "zip_4"=>"9310",
                               "zip_5"=>"80302",
                               "zip_9"=>"80302-9310",
                               "in_city"=>"Boulder",
                               "street_name"=>"LAKERIDGE",
                               "unit_number"=>"",
                               "pre_directional"=>"N",
                               "dpbc"=>"50",
                               "in_street_address"=>"2950 n lakeridge trl",
                               "county_number"=>"013",
                               "post_directional"=>"",
                               "street_address"=>"2950 N Lakeridge Trl",
                               "address_type"=>"S",
                               "city"=>"Boulder",
                               "in_zip"=>"80302",
                               "search_key"=>"80302931050"}
```
## Contributing
Contact: http://www.firstmoversadvantage.com

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).