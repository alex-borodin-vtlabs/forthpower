class UsersOnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_online_#{params['user_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
