class LabelsController < ApplicationController
  before_action :authenticate, only: [:search, :index, :create, :show]

  def search
    query = params[:q].strip if params[:q].present?
    if query.present? && query.length > 0
      @labels = Label.search(query).records.to_a
      render 'index', status: :ok
    else
      render json: {
        errors: true,
        message: "Please enter a search query."
      }, status: :bad_request
    end
  end

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
