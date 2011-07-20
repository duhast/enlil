class SessionsController < ApplicationController
  protect_from_forgery :except => :create


  def create
    auth = request.env['omniauth.auth']
    unless auth
      redirect_to :failure
    else
      set_current_user!(auth)
      render :layout => false
    end
  end

  def failure
    render :logout, :layout => false, :locals => {:error => params[:error] || 'Error while signing in'}
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
      :nick => auth_hash['user_info']['nickname'],
      :email => '',
      :url => auth_hash['public_profile_url'],
      :image => auth_hash['user_info']['image'],
      :auth_uid => auth_hash['uid'],
      :auth_provider => auth_hash['provider']
    }
  end
  
end
