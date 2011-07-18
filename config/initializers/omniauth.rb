Rails.application.config.middleware.use OmniAuth::Builder do
  # load certificates
  require "openid/fetchers"
  OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt"
  
  provider :facebook, '192719554114928', '779c86cdaf128759560994586b70ca10', :callback_path => '/auth/facebook/callback/'
  provider :linked_in, 'uYUbLKMgGUIWpyFd1VD3Y4Beb1C_a5F4XwxnBPsGZuxAgzp69uXLw6jxr_WDfjV9', 'JkwQ3w5Vak2VrlZWeZsGqbIMUA3ZpF0vAboK1VUz-oDa1kxaQFYzUuJqF_u4dE4D'
end


