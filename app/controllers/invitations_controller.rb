class InvitationsController < ApplicationController
  before_action :authenticate
  after_action :verify_authorized, only: [:index, :create, :destroy, :remind]

  def index
    authorize Invitation
    @invitations = Invitation.order(created_at: :asc)
    render 'index', show: :ok
  end

  def create
    authorize Invitation
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
    authorize Invitation
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
    authorize Invitation
    @invitation = Invitation.find(params[:id])
    ## todo:
  end

  private
  def invitation_params
    params.require(:invitations).map do |p|
      p.require(:invitation).permit(:email)
    end
  end

end
