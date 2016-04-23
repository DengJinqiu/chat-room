class UsersChannel < ApplicationCable::Channel
  def follow(data)
    # stop stream from all channel
    stop_all_streams

    # stream from user change
    stream_from "userChange"
    if data['messageId'].to_str.length > 0
      # stream from message change
      stream_from "#{data['messageId'].to_str}"
    end
  end
end
