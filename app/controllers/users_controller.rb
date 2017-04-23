class UsersController < ApplicationController
  before_action :authenticate, only: [:index]

  def index
    @users = User.where(blocked: false).order(name: :asc)
    render 'index', status: :ok
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      render json: { access_token: JwtTokenIssuer.generate_token(@user.id) }, status: :ok
    else
      render json: { errors: true }, status: :unauthorized
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

  private
  def user_params
    params.require(:user).permit(:email, :name, :username, :password, :timezone)
  end

end
