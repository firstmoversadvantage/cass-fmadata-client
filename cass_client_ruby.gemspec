Gem::Specification.new do |s|
  s.name        = 'cass-fmadata-client'
  s.version     = '1.0.2'
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
  s.add_runtime_dependency 'webmock'
  s.add_runtime_dependency 'dotenv'
end
