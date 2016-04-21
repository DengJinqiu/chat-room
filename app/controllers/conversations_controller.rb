class ConversationsController < ApplicationController
  def create
    Rails.logger.debug "Get message " << params[:conversation][:context] << \
                       " from " << params[:conversation][:selectedUser] << \
                       " to " << get_current_user()
    render js: "$('#message-board').append('ddd');"
  end
end

