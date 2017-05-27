class PusherController < ApplicationController
  before_action :authenticate, only: [:private_auth, :presence_auth]

  ## Authentication ##
  def auth
    response = Pusher.authenticate(params[:channel_name], params[:socket_id], {
      user_id: @current_user.id,
      user_info: {
        email: @current_user.email,
        username: @current_user.username,
        name: @current_user.name
      }
    })
    render json: response, status: :ok
  end

  ## Webhooks ##

end
