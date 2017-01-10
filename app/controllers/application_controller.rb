class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_popular

  def set_popular
    @populars = ChatRoom.includes(:user).all.order(cached_votes_total: :desc).first(5)
  end

  def admin_auth(role)
    authenticate_user!
    if current_user.role >= role
       return
    else
       redirect_to root_url # or whatever
    end
  end

  def admin_or_current(user, role)
    authenticate_user!
    if current_user.role >= role || current_user == user
       return
    else
       redirect_to root_url # or whatever
    end
  end

  def check_param_access(param, role)
    redirect_to root_url if param && current_user.role < role
  end
end
