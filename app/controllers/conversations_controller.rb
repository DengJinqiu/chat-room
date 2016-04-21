class ConversationsController < ApplicationController
  def create
    context = params[:conversation][:context]
    selectedUser = params[:conversation][:selectedUser]
    groupId = get_group_id selectedUser, get_current_user()

    params[:conversation][:groupId] = groupId
    params[:conversation][:user] = get_current_user()

    Rails.logger.debug "Get message " << context << " from " << get_current_user()
                       " to " << selectedUser

    conversation = Conversation.new conversation_params
    conversation.save

    command = "$('#message-board').append('<p>" + get_current_user() + ": " + context + "</p>');"
    ActionCable.server.broadcast groupId, {message: command}
    render js: command
  end

  private
    def conversation_params
      params.require(:conversation).permit(:groupId)
      params.require(:conversation).permit(:user)
      params.require(:conversation).permit(:context)
    end
end

