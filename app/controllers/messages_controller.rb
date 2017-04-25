class MessagesController < ApplicationController

  before_action :authenticate, only: [:index, :create, :show, :update, :destroy]
  before_action :set_card, only: [:index, :create, :show, :update, :destroy]
  before_action :set_page, only: [:index]
  after_action :verify_authorized, only: [:update, :destroy]

  def index
    @messages = @card.messages.includes(:user).order(created_at: :asc).page(@page)
    render 'index', status: :ok
  end

  def create
    @message = @card.messages.new(message_params)
    @message.user_id = @current_user.id
    if @message.save
      render 'show', status: :ok
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @message = @card.messages.find(params[:id])
    render 'show', status: :ok
  end

  def update
    @message = @card.messages.find(params[:id])
    authorize @message
    if @message.update(message_params)
      render 'show', status: :ok
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @message = @card.messages.find(params[:id])
    authorize @message
    if @message.destroy
      render 'show', status: :ok
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_card
    unless @card = Card.find(params[:card_id])
      render json: {
        errors: true,
        message: "Card not found."
      }, status: :not_found
    end
  end

end
