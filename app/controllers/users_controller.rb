class UsersController < ApplicationController
  def create
    Rails.logger.debug "Create " << params[:user][:name]

    @user = User.new(user_params)
    @user.save
    redirect_to :action => "index"
  end

  def new
  end

  def index
    verify_user
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
