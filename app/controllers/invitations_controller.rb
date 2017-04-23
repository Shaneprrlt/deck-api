class InvitationsController < ApplicationController
  before_action :authenticate, :admin_restricted

  def index
    @invitations = Invitation.order(created_at: :asc)
    render 'index', show: :ok
  end

  def create
    @invitations = Invitation.create(invitation_params)
    if @invitations.present?
      render 'index', show: :ok
    else
      render json: {
        errors: true
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    if @invitation.destroy
      render json: {}, status: :ok
    else
      render json: {
        errors: true
      }, status: :unprocessable_entity
    end
  end

  def remind
    # todo:
  end

  private
  def invitation_params
    params.require(:invitations).map do |p|
      p.require(:invitation).permit(:email)
    end
  end

end
