class NotificationsController < ApplicationController
  before_action :authenticate, only: [:search, :index, :mark_as_read, :mark_all_as_read]
  before_action :set_page, only: [:search, :index]

  def search
    query = params[:q].strip if params[:q].present?
    if query.present? && query.length > 0
      @notifications = Notification.search(query).records.page(@page).to_a
      render 'index', status: :ok
    else
      render json: {
        errors: true,
        message: "Please enter a search query."
      }, status: :bad_request
    end
  end

  def index
    @notifications = @current_user.notifications.order(created_at: :desc).page(@page)
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
