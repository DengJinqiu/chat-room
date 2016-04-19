class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def verify_user
    if current_user()
      Rails.logger.debug "Current user is " + current_user()
    else
      Rails.logger.debug "Current user does not exist, redirect to home page"
      redirect_to root_url
    end
  end

  def current_user
    return session[:current_user_id]
  end
end
