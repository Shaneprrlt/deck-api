class LabelsController < ApplicationController
  before_action :authenticate, only: [:index, :create, :show]

  def index
    @labels = Label.includes(:app).all
    render 'index', status: :ok
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      render 'show', status: :ok
    else
      render json: @label.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @label = Label.find(params[:id])
    render 'show', status: :ok
  end

  private
  def label_params
    params.require(:label).permit(:title)
  end

end
