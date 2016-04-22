class ConversationsController < ApplicationController
  def create
    context = params[:conversation][:context]
    selectedUser = params[:conversation][:selectedUser]
    groupId = get_group_id selectedUser, get_current_user()

    Rails.logger.debug "Get message " << context << " from " << get_current_user() << \
                       " to " << selectedUser

    conversation = Conversation.new conversation_params
    conversation.group_id = groupId
    conversation.user = get_current_user()
    conversation.save

    data = get_conversation_html(get_current_user(), context, conversation.updated_at)
    ActionCable.server.broadcast groupId, {action: 'newMessage', message: data, currentUser: get_current_user()}
    head :ok
  end

  def show
    Rails.logger.debug "Fetch conversations with group id" + params[:id]
    conversations = Conversation.select(:user, :context, :updated_at).where(group_id: params[:id])
    command = ""
    for conversation in conversations do
      command << "$('#message-board').append('" <<  get_conversation_html(conversation.user, conversation.context, conversation.updated_at) << "');"
    end
    render js: command
  end

  private
    def conversation_params
      params.require(:conversation).permit(:context)
    end

    def get_conversation_html(user, context, time)
      "<p>" + time.to_s(:db) + " <b>" + user + "</b>: " + context + "</p>"
    end
end

