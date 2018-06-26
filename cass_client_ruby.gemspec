Gem::Specification.new do |s|
  s.name        = 'cass-fmadata-client'
  s.version     = '0.0.0'
  s.date        = '2018-04-20'
  s.summary     = 'Client for CASS API'
  s.description = 'Client for CASS API'
  s.authors     = ['Brian Long', 'Marta Wójtowicz']
  s.email       = 'brian.long@firstmoversadvantage.com'
  s.files       = ['lib/cass_fmadata_client.rb',
                   'lib/cass_fmadata_client/base.rb',
                   'lib/cass_fmadata_client/loggable.rb',
                   'lib/cass_fmadata_client/connection.rb']
  s.homepage    = 'http://www.firstmoversadvantage.com/'
  s.license     = 'MIT'
  s.add_development_dependency 'pry'
  s.add_runtime_dependency 'webmock', '~> 1.7.10'
  s.add_runtime_dependency 'dotenv'
end
