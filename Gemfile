source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 8.0'
  gem "puppet-lint", '~> 4.0'
  gem "rspec", '~> 3.0'
  gem "rspec-puppet", '~> 4.0'
  gem "puppet-syntax", '~> 4.0'
  gem "puppetlabs_spec_helper", '~> 7.0'
  gem "facterdb"
end

group :development do
  gem "puppet-blacksmith"
  gem "guard-rake"
end
