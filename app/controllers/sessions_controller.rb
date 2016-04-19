class SessionsController < ApplicationController
  def create
    userName = params[:session][:name]
    Rails.logger.debug "Sign in as " + userName

    if User.exists?(name: userName)
      Rails.logger.debug userName + " is a valid user"
      session[:current_user_id] = userName
      redirect_to :controller => "users", :action => "index"
    else
      Rails.logger.debug userName << " does not exist"
      render :action => "new"
    end
  end

  def new
  end

  def index
  end
end
