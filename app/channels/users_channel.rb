class UsersChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams

    stream_from "userChange"
    if data['messageId'].to_str.length > 0
      stream_from "#{data['messageId'].to_str}"
    end
  end

  def unfollow
    stop_all_streams
  end
end
