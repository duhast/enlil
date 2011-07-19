class SessionsController < ApplicationController
  protect_from_forgery :except => :create


  def create
    auth = request.env['omniauth.auth']
    set_current_user!(auth)
    render :layout => false
  end

  def failure
    render :text => 'fail'
  end

  def logout
    set_current_user!(nil)
    render :layout => false
  end

protected
  def set_current_user!(auth_hash)
    session[:current_user] = auth_hash.nil? ? nil : build_current_user(auth_hash)
  end
  
  def build_current_user(auth_hash)
    {
      :name => auth_hash['user_info']['name'],
      :nick => auth_hash['nickname'],
      :email => '',
      :url => auth_hash['public_profile_url'],
      :image => auth_hash['image']
    }
  end
  
end
