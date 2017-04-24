class CardsController < ApplicationController
  before_action :authenticate, only: [:index, :create, :show, :update, :destroy, :mark_occurence]
  after_action :verify_authorized, only: [:update, :destroy]

  def index
    @cards = Card.includes(:user, :card_type, app: [:platform]).all
    render 'index', status: :ok
  end

  def create
    @card = @current_user.cards.new(card_params)
    if @card.save
      @card.labels << Label.where(id: labels_params)
      @card.apply_to_decks
      render 'show', status: :ok
    else
      render json: @card.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @card = Card.includes(:user, :card_type, app: [:platform]).find(params[:id])
    render 'show', status: :ok
  end

  def update
    @card = Card.find(params[:id])
    authorize @card
    if @card.update(card_params)
      @card.clear_labels.reload
      @card.labels << Label.where(id: labels_params)
      @card.apply_to_decks
      render 'show', status: :ok
    else
      render json: @card.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @card = Card.find(params[:id])
    authorize @card
    if @card.destroy
      render json: {}, status: :no_content
    else
      render json: @card.errors.full_messages, status: :unprocessable_entity
    end
  end

  def mark_occurence
    @card = Card.find(params[:card_id])
    occurence = CardOccurence.new(user: @current_user, card: @card)
    if occurence.save
      render 'show', status: :ok
    else
      render json: occurence.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def card_params
    params.require(:card).permit(:card_type_id, :app_id, :title, :description)
  end

  def labels_params
    params[:card][:labels].length > 0 ?
      params.require(:card).require(:labels) : []
  end

end
