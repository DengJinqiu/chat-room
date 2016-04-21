class UsersController < ApplicationController
  def create
    Rails.logger.debug "Create " << params[:user][:name]

    user = User.new(user_params)
    user.save
    session[:current_user_id] = user.name
    ActionCable.server.broadcast "all_users", \
      {action: "new_user", \
       message: "<li class=\"list-group-item\"> \
        <a href=\"/users?selectedUser=" + params[:user][:name] + "\">" \
          + params[:user][:name] + "</a></li>"}
    redirect_to :action => "index"
  end

  def new
  end

  def index
    verify_user
    @currentUser = get_current_user()
    @userNames = User.pluck(:name)
    @selectedUser = params[:selectedUser]
    if @selectedUser
      @groupId = get_group_id @currentUser, @selectedUser
    end
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
