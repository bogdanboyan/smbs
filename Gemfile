# debian environment
# apt-get install libxslt1-dev
# apt-get install libmysql-ruby libmysqlclient-dev
# apt-get install imagemagick
# apt-get install geoip-bin libgeoip1 libgeoip-dev

source 'http://rubygems.org'

gem 'rails',                  '3.0.3'

gem 'mysql2',                 '0.2.3'
gem 'unicorn',                '1.1.4'

gem 'rmagick',                '2.12.2'
gem 'paperclip',              '2.3.3'
gem 'RedCloth',               '4.2.3'

gem 'geoip-c',                :git => 'git://github.com/zarqman/geoip.git'

gem 'exception_notification_rails3', '1.0.0', :require => 'exception_notifier'

gem 'aasm',                   '2.2.0'

gem 'will_paginate',          '3.0.pre2'

group :test do
  gem 'rspec',                '2.0.1'
  gem "shoulda",              '2.11.3'
  gem 'rspec-rails',          '2.0.1'
  gem 'factory_girl',         '1.3.2'
  gem 'cucumber',             '0.8.5'
  gem 'cucumber-rails',       '0.3.2'
  gem 'selenium-webdriver',   '0.1.0'
  gem 'capybara',             '0.3.9'
  gem 'database_cleaner',     '0.6.0'
end

group :production do
  gem 'scout',                '5.1.4'
  gem 'request-log-analyzer', '1.9.8'
end