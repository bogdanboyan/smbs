# debian environment
# apt-get install libxslt1-dev
# apt-get install libmysql-ruby libmysqlclient-dev
# apt-get install imagemagick
# apt-get install geoip-bin libgeoip1 libgeoip-dev

source 'http://rubygems.org'

gem 'rails',                  '3.0.0'

gem 'mysql2',                 '0.2.3'
gem 'unicorn',                '1.1.4'

gem 'rmagick',                '2.12.2'
gem 'paperclip',              '2.3.3'
gem 'RedCloth',               '4.2.3'

gem 'geoip-c',                :git => 'git://github.com/zarqman/geoip.git'

gem 'exception_notification_rails3', '1.0.0', :require => 'exception_notifier'

group :test do
  gem 'rspec',                '2.0.0'
  gem 'rspec-rails',          '2.0.0'
  gem 'factory_girl',         '1.3.2'
  gem 'cucumber',             '0.8.5'
  gem 'cucumber-rails',       '0.3.2'
  gem 'selenium-webdriver',   '0.0.29'
  gem 'capybara',             '0.3.9'
  gem 'database_cleaner',     '0.6.0.rc.3'
end