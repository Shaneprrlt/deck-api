class PreferencesController < ApplicationController
  before_action :authenticate, only: [:show, :update]

  def show
    @user = @current_user
    render '/users/me', status: :ok
  end

  def update
    @user = @current_user
    if @user.preference.update(preference_params)
      render '/users/me', status: :ok
    else
      render json: @user.preference.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def preference_params
    params.require(:preference)
      .permit(
        card_is_created: [:push_notification, :email],
        card_changes_status: [:push_notification, :email],
        previous_card_reoccurs: [:push_notification, :email],
        message_is_created: [:push_notification, :email],
        app_is_created: [:push_notification, :email]
      )
  end

end
