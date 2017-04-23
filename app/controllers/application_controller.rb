class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

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

  def admin_restricted
    unless @current_user.has_role?(:admin)
      render json: {
        error: true,
        message: "You must have admin privileges to access this resource.",
        code: 401,
        status: 401
      }, status: :unauthorized and return
    end
  end

end
