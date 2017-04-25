class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit

  ## Custom Error Response Handling ##
  rescue_from Pundit::NotAuthorizedError, with: :pundit_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :generic_not_found

  def current_user
    @current_user ||= nil
  end

  def authenticate
    unless @current_user = authenticate_with_http_token { |t,o| JwtTokenIssuer.user_from_token(t) }
      render json: {
        error: true,
        message: "Invalid authentication credentials.",
        code: 401,
        status: 401
      }, status: :unauthorized and return
    end
  end

  def pundit_not_authorized
    render json: {
      error: true,
      message: "You are not authorized to access this resource.",
      code: 401,
      status: 401
    }, status: :unauthorized and return
  end

  def generic_not_found
    render json: {
      error: true,
      message: "Resource not found.",
      code: 404,
      status: 404
    }, status: :not_found and return
  end

  def set_page
    @page = params[:page].present? && params[:page].to_i > 0 ? params[:page] : 1
  end

end
