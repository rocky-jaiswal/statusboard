source 'https://rubygems.org'

gem 'rails', '4.0.2'

gem 'simple_form'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'devise'
gem 'figaro'
gem 'haml-rails'
gem 'mongoid', '~> 4', :github=>"mongoid/mongoid"
gem 'multi_json'

group :development do
  gem 'thin'
  gem 'html2haml'
  gem 'zurb-foundation'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'mongoid-rspec', '>= 1.6.0', :github=>"evansagge/mongoid-rspec"
  gem 'turnip', '>= 1.1.0'
  gem 'capybara'
end

gem 'rails_12factor', group: :production
#gem 'capistrano'
ruby "2.1.1"