class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def verify_user
    if get_current_user()
      Rails.logger.debug "Current user is " + get_current_user()
      return true
    else
      Rails.logger.debug "Current user does not exist"
      return false
    end
  end

  def get_current_user
    return session[:current_user_id]
  end

  def get_group_id(user1, user2)
    return user1 > user2 ? user1 + "*" + user2 : user2 + "*" + user1
  end

  def get_raw_conversation_html(user, context, time)
    "<p>" + time.to_s(:db) + " <b>" + user + "</b>: " + context + "</p>"
  end

  def get_colored_conversation_html(user, context, time)
    if get_current_user().eql? user
      return "<div style=\"color: dodgerblue\">" + get_raw_conversation_html(user, context, time) + "</div>"
    else
      return get_raw_conversation_html(user, context, time)
    end
  end

  def get_no_message_alert()
    "<p style=\"color: orangered\">No more messages to show.</p>"
  end
end
