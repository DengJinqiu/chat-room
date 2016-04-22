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
    render js: "$('#sendContext').val('');"
  end

  def show
    lastMessageTime = Time.at(params[:lastMessageTime].to_f)
    Rails.logger.debug "Fetch conversation with group id " + params[:id] + " before " + lastMessageTime.to_s(:db)
    conversation = Conversation.where("group_id=? and updated_at < ?", params[:id], lastMessageTime).order("updated_at DESC").first
    Rails.logger.debug "Get conversation with group id " << conversation.group_id + " time stamp " + conversation.updated_at.to_s(:db) + " context " + conversation.context
    render json: {html: get_conversation_html(conversation.user, conversation.context, conversation.updated_at),
                  lastMessageTime: conversation.updated_at.to_f}
  end

  private
    def conversation_params
      params.require(:conversation).permit(:context)
    end
end

