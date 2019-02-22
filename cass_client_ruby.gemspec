Gem::Specification.new do |s|
  s.name        = 'cass-fmadata-client'
  s.version     = '1.0.4'
  s.date        = '2018-08-21'
  s.summary     = 'Client for CASS API'
  s.description = 'Client for CASS API'
  s.authors     = ['Brian Long', 'Marta Wójtowicz']
  s.email       = 'brian.long@firstmoversadvantage.com'
  s.files       = ['lib/cass_fmadata_client.rb',
                   'lib/cass_fmadata_client/base.rb',
                   'lib/cass_fmadata_client/connection.rb']
  s.homepage    = 'http://www.firstmoversadvantage.com/'
  s.license     = 'MIT'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'minitest'
  s.add_runtime_dependency 'webmock', "<= 1.24.6"
  s.add_runtime_dependency 'dotenv', "<= 1.1"
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'hashdiff', '~> 0.2.2'
  s.add_development_dependency "appraisal"
end
