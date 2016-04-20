class UsersChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "all_users"
  end

  def unfollow
    stop_all_streams
  end
end
