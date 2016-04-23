class UsersController < ApplicationController
  def create
    Rails.logger.debug "Create " << params[:user][:name]

    if User.exists?(name: params[:user][:name])
      render js: "$('#board').append('<div class=\"alert alert-danger\">" + params[:user][:name] + " has been taken." + "<\div>')"
      return
    end

    user = User.new(user_params)
    session[:current_user_id] = user.name

    ActionCable.server.broadcast "userChange", \
      {action: "newUser", \
       message: "<li class=\"list-group-item\"> \
        <a href=\"/users?selectedUser=" + params[:user][:name] + "\">" \
          + params[:user][:name] + "</a></li>"}

    user.save

    redirect_to :action => "index"
  end

  def new
  end

  def index
    if not verify_user
      redirect_to root_url
      return
    end
    @currentUser = get_current_user()
    @userNames = User.where.not(name: @currentUser).pluck(:name)
    @selectedUser = params[:selectedUser]
    if @selectedUser
      @groupId = get_group_id @currentUser, @selectedUser
      conversation = Conversation.where(group_id: @groupId).order("updated_at DESC").first
      if conversation
        @lastMessageTime = conversation.updated_at.to_f
        @lastMessageHtml = get_colored_conversation_html(conversation.user, conversation.context, conversation.updated_at)
      else
        @lastMessageHtml = get_no_message_alert()
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
