# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_smbs_session',
  :secret      => '2418179706c4d3bdf68c9b07070492cddf9c182b7735b5c19bcc135d9e81d27d1dfd12b870b6eb9237caa75bbd534017887ebd9a2ee51f3d47927c1d6c7f08d9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
