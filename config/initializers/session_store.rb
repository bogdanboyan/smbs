# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_smbs_session',
  :secret      => 'c8eb0deed8fde0d1c58963026404bbfba7f7bafc1f508903105d2b0fc524589136ada4c4ad8d59e674b2946b81bf118f6d75502957bef2c2e3601da8e5c7f885'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
