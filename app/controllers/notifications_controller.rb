class NotificationsController < ApplicationController
  before_action :authenticate, only: [:index, :mark_as_read, :mark_all_as_read]

  def index
    @notifications = @current_user.notifications.order(created_at: :desc)
    render 'index', status: :ok
  end

  def mark_as_read
    @notification = @current_user.notifications.find(params[:notification_id])
    @notification.update(read: true)
    render 'show', status: :ok
  end

  def mark_all_as_read
    @current_user.notifications.where(read: false).update_all(read: true)
    @notifications = @current_user.notifications.order(created_at: :desc)
    render 'index', status: :ok
  end
end
