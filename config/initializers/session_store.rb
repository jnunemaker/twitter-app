# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twitter-app_session',
  :secret      => 'c8c53179cfd5e7bd51a73749dd09875355b725e93480c224de9725dd2abfee616bda9e0a32e2102a387b805d9ae1f645978d6be8516241bd2ab06cebef06a451'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
