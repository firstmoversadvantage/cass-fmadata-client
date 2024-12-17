Gem::Specification.new do |s|
  s.name        = 'cass-fmadata-client'
  s.version     = '1.1.0'
  s.date        = '2024-11-07'
  s.summary     = 'Client for CASS API'
  s.description = 'Client for CASS API'
  s.authors     = ['Brian Long', 'Radosław Stolarski', 'Paweł Jermalonek', 'Ada Borzemska']
  s.email       = 'brian.long@firstmoversadvantage.com'
  s.files       = ['lib/cass_fmadata_client.rb',
                   'lib/cass_fmadata_client/base.rb',
                   'lib/cass_fmadata_client/connection.rb']
  s.homepage    = 'https://www.fmadata.com/'
  s.license     = 'MIT'
  s.add_development_dependency 'pry', '~> 0.14.2'
  s.add_development_dependency 'webmock', '~> 3.24.0'
  s.add_runtime_dependency 'dotenv', '~> 2.7.6'
end
