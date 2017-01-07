class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin_auth(role)
    authenticate_user!
    if current_user.role >= role
       return
    else
       redirect_to root_url # or whatever
    end
  end
end
