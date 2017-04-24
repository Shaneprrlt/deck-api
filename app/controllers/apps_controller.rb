class AppsController < ApplicationController
  before_action :authenticate, only: [:index, :create, :show, :update, :destroy, :cards]

  def index
    authorize App
    @apps = App.includes(:platform).where(removed: false)
    render 'index', status: :ok
  end

  def create
    authorize App
    @app = App.new(app_params)
    if @app.save
      @developers = User.where(id: app_developers_params).map do |u|
        if u.has_role?(:developer)
          u.add_role(:contributor, @app)
        end
      end

      render 'show', status: :ok
    else
      render json: @app.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    authorize App
    @app = App.find(params[:id])
    render 'show', status: :ok
  end

  def update
    authorize App
    @app = App.find(params[:id])
    if @app.update(app_params)

      # clear contributors
      @app.clear_contributors.reload

      @developers = User.where(id: app_developers_params).map do |u|
        if u.has_role?(:developer)
          u.add_role(:contributor, @app)
        end
      end

      render 'show', status: :ok
    else
      render json: @app.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    authorize App
    @app = App.find(params[:id])
    @app.update(removed: true)
    render json: {}, status: :no_content
  end

  def cards
    @app = App.find(params[:app_id])
    offset = params[:page].present? && params[:page].to_i > 0 ? (params[:page].to_i - 1) * Settings.card_load_limit : 0
    @cards = @app.cards.limit(Settings.card_load_limit).offset(offset).order(created_at: :desc)
    render '/cards/index', status: :ok
  end

  private
  def app_params
    params.require(:app).permit(:name, :platform_id)
  end

  def app_developers_params
    params[:app][:developers].length > 0 ?
      params.require(:app).require(:developers) : []
  end

end
