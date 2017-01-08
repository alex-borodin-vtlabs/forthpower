class VotesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "votes_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    return if !current_user
    chat_room = ChatRoom.find_by_id(data['chat_room_id'])
    chat_room.vote_by voter: current_user, vote: data['vote'] unless current_user.voted_for? chat_room
    VotesBroadcastJob.perform_later(chat_room)
  end
end
