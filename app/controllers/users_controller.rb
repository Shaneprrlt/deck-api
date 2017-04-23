class UsersController < ApplicationController

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
