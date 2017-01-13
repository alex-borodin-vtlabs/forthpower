class UsersOnlineBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user)
    ActionCable.server.broadcast "users_online_#{user.id}_channel",
                                 user: render_user(user)
  end

  private

  def render_user(user)
    UsersController.render partial: 'shared/user_avatar', locals: {user: user}
  end
end
