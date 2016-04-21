class UsersChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    Rails.logger "my log here*******************************8"
    Rails.logger "my log follow" + data['message_id']
    # stream_from "#data['message_id']"
    stream_from "dddd"
  end

  def unfollow
    stop_all_streams
  end
end
