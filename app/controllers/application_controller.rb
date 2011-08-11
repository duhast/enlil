class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :set_content_type

  def current_user
    @current_user ||= session[:current_user]
  end

  def user_signed_in?
    !!current_user
  end
  
  helper_method :current_user, :user_signed_in?


protected

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end

  def enki_config
    @@enki_config = Enki::Config.default
  end
  helper_method :enki_config

  def authenticated_user_required
    unless user_signed_in?
      render :status => 401
    end
  end

end
