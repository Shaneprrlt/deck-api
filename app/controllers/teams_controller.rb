class TeamsController < ApplicationController

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
