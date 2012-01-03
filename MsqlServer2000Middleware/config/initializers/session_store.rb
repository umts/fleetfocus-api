# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MsqlServer2000Middleware_session',
  :secret      => '696b7f3ac7f8ccd17615fd4f893d1d72a327565b84f32d9701efc1222276fe1412164dcce303e3422db518a5845a6e5c55e10fc2372613a6703c5527cd924ca6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
