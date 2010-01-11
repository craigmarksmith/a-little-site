# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_thing_session',
  :secret      => '888bbe152839926daa427bee025a7dcad8eda8688ed513ee556ec30d59029e1c0d21ff6dfaabd49f9511a44beb4fcfcf84be64e4514491d87bc23f17ba7ba29b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
