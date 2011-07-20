class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :require_admin, :except => :login

  def login
    render 'admin/login', :layout => 'login'
  end

  protected

  def require_admin
    return redirect_to(admin_login_path) unless user_signed_in? && admin_logged_in?
  end
  
  def admin_logged_in?
    enki_config.author_auths.include?({:provider => current_user[:auth_provider], :uid => current_user[:auth_uid]})
  end

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end
end
