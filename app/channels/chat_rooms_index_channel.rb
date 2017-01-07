class ChatRoomsIndexChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_index_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
