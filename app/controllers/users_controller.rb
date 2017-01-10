class UsersController < ApplicationController
  def index
    @users =
      if params[:search]
        User.search(params[:search]).order('created_at DESC')
      else
        User.all.order('created_at DESC')
      end
  end

  def show
    @user = User.includes(:chat_rooms).find_by(id: params[:id])
  end

  def edit
  end

  def update
  end

  private
    def chat_room_params
      params.require(:user).permit(:search, :role)
    end
end
