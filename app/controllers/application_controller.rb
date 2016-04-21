class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def verify_user
    if get_current_user()
      Rails.logger.debug "Current user is " + get_current_user()
    else
      Rails.logger.debug "Current user does not exist, redirect to home page"
      render root_url
    end
  end

  def get_current_user
    return session[:current_user_id]
  end

  def get_group_id(user1, user2)
    return user1 > user2 ? user1 + "*" + user2 : user2 + "*" + user1
  end
end
