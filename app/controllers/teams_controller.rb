class TeamsController < ApplicationController
  before_action :authenticate, only: [:index]

  def query_record
    if params[:subdomain].present?
      @team = Team.find_by_subdomain!(params[:subdomain].downcase)
      render 'show', status: :ok
    else
      render json: {
        errors: true,
        message: "Must pass a subdomain."
      }, status: :bad_request
    end
  end

  def index
    @team = @current_user.team
    render 'show', status: :ok
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      render 'show', status: :ok
    else
      render json: @team.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @team = Team.find(params[:id])
    render 'show', status: :ok
  end

  private
  def team_params
    params.require(:team).permit(:name, :subdomain, :email)
  end

end
