class UsersChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "#{data['messageId'].to_str}"
  end

  def unfollow
    stop_all_streams
  end
end
