# debian environment
# apt-get install libxslt1-dev
# apt-get install libmysql-ruby libmysqlclient-dev
# apt-get install imagemagick
# apt-get install geoip-bin libgeoip1 libgeoip-dev
# apt-get install libcurl3-gnutls-dev libcurl3-openssl-dev

source 'http://rubygems.org'

gem 'rails',                  '3.0.3'

gem 'mysql2',                 '0.2.3'
gem 'unicorn',                '3.1.0'

# gem 'authlogic',              '2.1.6'
gem 'authlogic', :git => 'git://github.com/railsware/authlogic.git', :tag => 'v2.1.6.1'
gem 'dynamic_form',           '1.1.3'

gem 'rmagick',                '2.12.2'
gem 'paperclip',              '2.3.3'
gem 'RedCloth',               '4.2.3'

gem 'geoip-c',                :git => 'git://github.com/zarqman/geoip.git'

gem 'exception_notification_rails3', '1.2.0', :require => 'exception_notifier'

gem 'aasm',                   '2.2.0'

gem 'will_paginate',          '3.0.pre2'

gem 'escape_utils'
gem 'nokogiri',               '1.4.4'
gem 'patron',                 '0.4.9'

gem 'web_resource_bundler', :git => 'git://github.com/railsware/web-bundler.git'

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'factory_girl'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'selenium-webdriver',   '0.1.0'
  gem 'capybara',             '0.3.9'
  gem 'database_cleaner'
end

group :production do
  gem 'scout'
  gem 'request-log-analyzer'
  gem 'mysql',                '2.8.1'
  gem 'highline'
end
