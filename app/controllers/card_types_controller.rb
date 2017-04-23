class CardTypesController < ApplicationController
  before_action :authenticate, only: [:index]

  def index
    @card_types = CardType.all
    render 'index', status: :ok
  end

end
