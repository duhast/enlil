class SessionsController < ApplicationController
  protect_from_forgery :except => :create


  def create
    auth = request.env['omniauth.auth']
    return redirect_to :failure unless auth

    set_current_user!(auth)
    render :layout => false
  end

  def failure
    render :logout, :layout => false, :locals => {:error => params[:message] || 'Error while signing in'}
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
    usr_hash = {
      :name => auth_hash['user_info']['name'],
      :nick => auth_hash['user_info']['nickname'],
      :auth_uid => auth_hash['uid'],
      :auth_provider => auth_hash['provider'],
      :email => (auth_hash['user_info']['email'] || ''),
      :image => auth_hash['user_info']['image']
    }
    
    usr_hash.merge!(
      case auth_hash['provider'].to_sym
        when :facebook then {
            :url => auth_hash['user_info']['urls']['Facebook']
        }
        when :linked_in then {
          :url => auth_hash['user_info']['public_profile_url']
        }
        when :twitter then {
            :url => auth_hash['user_info']['urls']['Twitter']
        }
        when :google, :yahoo then {
            :url => ''
        }
        when :github then {
            :url => auth_hash['user_info']['urls']['GitHub'],
            :image => "http://gravatar.com/avatar/#{auth_hash['extra']['user_hash']['gravatar_id']}?d=identicon"
        }
        when :vkontakte then {
            :url => auth_hash['user_info']['urls']['Vkontakte']
        }
        when :mailru then {
            :url => auth_hash['user_info']['urls']['Mailru']
        }
        when :myopenid, :openid then begin
            login = auth_hash['uid'].match(/\/\/([a-zA-Z0-9_-]+)\.myopenid\.com\/?/)[1]
            {
              :name => auth_hash['user_info']['name'] || login,
              :nick => auth_hash['user_info']['nickname'] || login,
              :email => (auth_hash['user_info']['email'] || ''),
              :image => auth_hash['user_info']['image'],
              :url => auth_hash['uid']
            }
        end
        else {}
      end
    )

    usr_hash
  end
  
end
