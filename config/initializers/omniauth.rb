Rails.application.config.middleware.use OmniAuth::Builder do
  # you need a store for OpenID; (if you deploy on heroku you need Filesystem.new('./tmp') instead of Filesystem.new('/tmp'))
  require 'openid/store/filesystem'

  # load certificates
  require "openid/fetchers"
  OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt"
  
  #TODO Facebook doesn't work after callback (env[omniauth.auth]==nil)
  provider :facebook, '192719554114928', '779c86cdaf128759560994586b70ca10', {:client_options => {:ssl => {:verify => false}}} 
  provider :linked_in, 'uYUbLKMgGUIWpyFd1VD3Y4Beb1C_a5F4XwxnBPsGZuxAgzp69uXLw6jxr_WDfjV9', 'JkwQ3w5Vak2VrlZWeZsGqbIMUA3ZpF0vAboK1VUz-oDa1kxaQFYzUuJqF_u4dE4D'
  provider :twitter, 'flEHJQdDdmkQz2wHv6TXPQ', 'RYaUvet38MSUk7O1hySzBHC9NFA0wSGpG7xUm2HA'
  provider :github, '45ed5450636de781d817', '9dd982962cb41d8872dffd209b9da58504c7c604', {:client_options => {:ssl => {:verify => false}}}


  provider :vkontakte, '2417506', 'G88DKxd8MxUpjxdUMeV3', {:client_options => {:ssl => {:verify => false}}}
  provider :mailru, '635450', '377398ef8b335c507a1c51e87b6337a0', {:private_key => 'd0cecf668e1814ae95c725dc4fbcb0ee', :client_options => {:ssl => {:verify => false}}}


  # generic openid
  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'

  # dedicated openid
  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  # provider :google_apps, OpenID::Store::Filesystem.new('./tmp'), :name => 'google_apps'
  # /auth/google_apps; you can bypass the prompt for the domain with /auth/google_apps?domain=somedomain.com

  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'yahoo', :identifier => 'yahoo.com'
  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'myopenid', :identifier => 'myopenid.com'

  # Sign-up urls for Facebook, Twitter, and Github
  # https://developers.facebook.com/setup
  # https://github.com/account/applications/new
  # https://developer.twitter.com/apps/new
end


