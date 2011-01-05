# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Smbs::Application.initialize!

# Fix issue when I18n.locale is :en ONLY in production mode
I18n.locale = :ru

