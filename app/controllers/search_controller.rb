class SearchController < ApplicationController
  before_action :authenticate, only: [:index]

  def index
    query = params[:q].strip
    if query.present? && query.length > 0

      ## Elasticsearch Query ##
      results = Elasticsearch::Model
        .search(query, [Platform, CardType, User, Deck, Card, Message, Notification, Label])
        .records.to_a
      
      render json: results.to_json, status: :ok

    else
      render json: {
        errors: true,
        message: "Please enter a search query."
      }, status: :bad_request
    end
  end

end
