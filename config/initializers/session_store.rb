# Be sure to restart your server when you modify this file.

Enki::Application.config.session_store :cookie_store

Enki::Application.config.session = {
  :key          => '_enlil_session',     # name of cookie that stores the data
  :domain       => nil,                         # you can share between subdomains here: '.communityguides.eu'
  :expire_after => 1.day,                     # expire cookie
  :secure       => false,                       # fore https if true
  :httponly     => true,                        # a measure against XSS attacks, prevent client side scripts from accessing the cookie

  :secret      => '448a6ccd03fc5f1d484b15d69f09adb327a31a21d1ac8cbbbd676d077306587bf841a13eb2a5df79a7610988915b99e66991c5b8893f1d091c23d897547f5bd3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Enki::Application.config.session_store :active_record_store
