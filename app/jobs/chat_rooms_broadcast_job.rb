class ChatRoomsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat_room, action)
      ActionCable.server.broadcast "chat_rooms_index_channel",
                                  message: render_post(chat_room)
  end

  private

  def render_post(chat_room)
    ChatRoomsController.render partial: 'chat_rooms/chat_room', locals: {chat_room: chat_room}
  end
end
