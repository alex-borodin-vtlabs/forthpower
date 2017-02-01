class ChatRoomsController < ApplicationController
  before_action only: [:new, :create, :update, :edit] { |c| c.admin_auth 1 }
  before_action :set_chat_room, only: [:edit, :update]
  before_action :check_author, only: [:edit, :update]
  def index
    @chat_rooms =
      if params[:search]
        ChatRoom.includes(:user).search(params[:search]).order('created_at DESC').page(1).per(5).padding(params[:padding])
      else
        ChatRoom.includes(:user).all.order('created_at DESC').page(1).per(5).padding(params[:padding])
      end
      respond_to :html, :js
  end

  def new
    @chat_room = ChatRoom.new
  end

  def show
    @chat_room = ChatRoom.includes(:user).includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Post added!'
      redirect_to @chat_room
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @chat_room.update_attributes(chat_room_params)
      flash[:success] = 'Post saved!'
      redirect_to @chat_room
    else
      flash[:error] = 'Post not saved!'
      render 'edit'
    end
  end

  private
  def set_chat_room
    @chat_room = ChatRoom.includes(:user).find_by(id: params[:id])
  end

  def chat_room_params
    params.require(:chat_room).permit(:title, :post, :search, :padding)
  end

  def check_author
    if current_user != @chat_room.user
      redirect_to root_path
    end
  end
end
