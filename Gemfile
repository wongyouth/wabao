source 'https://rubygems.org'

gem 'localized_country_select', '>= 0.9.2'
gem 'rails', '3.2.11'
gem 'rails-i18n'
gem 'devise-i18n'
#gem 'rails_admin-i18n'
gem 'cancan'
gem 'open_taobao'
gem 'highline'
gem 'hash_extension'

gem 'twitter-bootstrap-rails'
gem 'less-rails'
gem 'therubyracer'
gem 'chinese_pinyin'
gem "devise"
gem 'rufus-scheduler', :require => false

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'mongoid', "~> 3.0.0"
gem 'haml-rails'
gem 'rails_admin'
#gem 'galetahub-simple_captcha', :require => 'simple_captcha', git: 'git://github.com/galetahub/simple-captcha.git'
gem "wolcanus-simple_captcha", :require => "simple_captcha"
#gem 'patron'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'turbo-sprockets-rails3'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
end

gem 'jquery-rails'
gem 'kaminari'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'



group :development, :test do
  gem 'pry-nav'
  gem 'rspec-rails'
  gem 'capistrano-unicorn', :require => false
  gem 'debugger' if RUBY_VERSION < '2.0'
  gem 'quiet_assets'
end

group :production do
  gem 'unicorn'
  gem 'mysql2'
end

group :profile do
  gem 'ruby-prof'
end

