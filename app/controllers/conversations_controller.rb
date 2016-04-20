class ConversationsController < ApplicationController
  def create
    Rails.logger.debug "Get message " << params[:conversation][:context] << \
                       " from " << params[<< " to " << get_current_user()
    render :controller => "users", :action => "index"
  end
end

