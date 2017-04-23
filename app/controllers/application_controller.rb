class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :pundit_not_authorized

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
end
