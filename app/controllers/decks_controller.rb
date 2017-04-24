class DecksController < ApplicationController
  before_action :authenticate, only: [:index, :create, :show, :update, :destroy]

  def index
    # todo: implement service to build users
    # deck payload based upon role, decks, query params (like just unreads, all cards, etc)
    # @decks = DeckService.build_index(@current_user, params)
    @decks = @current_user.decks.all
    render 'index', status: :ok
  end

  def create
    @deck = @current_user.decks.new(deck_params)
    if @deck.save
      @deck.labels << Label.where(id: labels_params)
      @deck.add_cards_to_deck
      render 'show', status: :ok
    else
      render json: @deck.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @deck = @current_user.decks.find(params[:id])
    @offset = params[:page].present? && params[:page].to_i > 0 ? (params[:page].to_i - 1) * Settings.card_load_limit : 0
    render 'show', status: :ok
  end

  def update
    @deck = @current_user.decks.find(params[:id])
    if @deck.update(deck_params)
      @deck.clear_labels.reload
      @deck.labels << Label.where(id: labels_params)
      @deck.add_cards_to_deck
      render 'show', status: :ok
    else
      render json: @deck.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @deck = @current_user.decks.find(params[:id])
    if @deck.destroy
      render json: {}, status: :no_content
    else
      render json: @deck.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def deck_params
    params.require(:deck).permit(:title)
  end

  def labels_params
    params[:deck][:labels].length > 0 ?
      params.require(:deck).require(:labels) : []
  end

end
