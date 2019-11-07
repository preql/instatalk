class UserService
  def initialize(user:, online:)
    @user = user
    @online = online
  end

  def perform
    update_status!
    broadcast_all_users
  end

  private

  def update_status!
    @user.update! online: @online
  end

  def broadcast_all_users
    ActionCable.server.broadcast 'appearance_channel',
                                 users_online: render_users
  end

  def render_users
    ApplicationController.renderer.render(partial: 'users/user', collection: User.online)
  end
end