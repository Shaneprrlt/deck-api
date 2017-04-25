class SearchController < ApplicationController
  before_action :authenticate, only: [:index]
  before_action :set_page, only: [:index]

  def index
    query = params[:q].strip
    if query.present? && query.length > 0

      @search_results = Elasticsearch::Model
        .search(query, [Platform, CardType, User, Deck, Card, Message, Label])
        .page(@page)
        .records.each_with_hit

      render 'index', status: :ok
    else
      render json: {
        errors: true,
        message: "Please enter a search query."
      }, status: :bad_request
    end
  end

end
