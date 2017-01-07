class ChatRoomsController < ApplicationController
  before_action only: [:new, :create] { |c| c.admin_auth 2 }
  def index
    @chat_rooms = ChatRoom.all.order(created_at: :desc)
  end

  def new
    @chat_room = ChatRoom.new
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Post added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :post)
  end
end
