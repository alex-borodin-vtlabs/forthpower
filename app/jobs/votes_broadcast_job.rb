class VotesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat_room)
    ActionCable.server.broadcast "votes_#{chat_room.id}_channel",
                                 vote: render_vote(chat_room)
  end

  private

  def render_vote(chat_room)
    ChatRoomsController.render partial: 'shared/votes', locals: {chat_room: chat_room}
  end
end
