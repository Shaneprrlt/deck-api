class UsersController < ApplicationController
  before_action :authenticate, only: [:me, :search, :index,:update, :destroy]
  after_action :verify_authorized, only: [:update, :destroy]

  def me
    @user = @current_user
    render 'show', status: :ok
  end

  def search
    query = params[:q].strip if params[:q].present?
    if query.present? && query.length > 0
      @users = User.search(query).records.to_a
      render 'index', status: :ok
    else
      render json: {
        errors: true,
        message: "Please enter a search query."
      }, status: :bad_request
    end
  end

  def index
    @users = User.where(blocked: false).order(name: :asc)
    render 'index', status: :ok
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      unless @user.blocked
        render json: { access_token: JwtTokenIssuer.generate_token(@user.id) }, status: :ok
      else
        render json: {
          errors: true,
          message: "You have been blocked from this team."
        }, status: :unauthorized
      end
    else
      render json: {
        errors: true,
        message: "Invalid credentials."
      }, status: :unauthorized
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'show', status: :ok
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render 'show', status: :ok
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      render 'show', status: :ok
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    authorize User
    @user = User.find(params[:id])
    @user.update(blocked: true)
    render json: {}, status: :no_content
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :username, :password, :timezone)
  end

end
