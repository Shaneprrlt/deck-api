class PlatformsController < ApplicationController
  before_action :authenticate, only: [:index]
  after_action :verify_authorized, only: [:index]

  def index
    authorize Platform
    @platforms = Platform.all
    render 'index', status: :ok
  end

end
