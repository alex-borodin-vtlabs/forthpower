class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action only: [:edit, :update] { |c| c.admin_or_current @user, 3 }
  before_action only: [:update] { |c| c.check_param_access user_params[:role], 3}
  def index
    @users =
      if params[:search]
        User.search(params[:search]).order('created_at DESC')
      else
        User.all.order('created_at DESC')
      end
  end

  def show

  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'User saved!'
      render 'edit'
    else
      flash[:error] = 'User not saved!'
      redirect_to users_path
    end
  end

  private
    def set_user
      @user = User.includes(:chat_rooms).find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:search, :role, :bio, :avatar_url)
    end
end
