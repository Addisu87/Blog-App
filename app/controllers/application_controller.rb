class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = %i[name email password password_confirmation current_password]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    if header
      header = header.split.last

      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find_by_id!(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound || JWT::DecodeError => e
        render json: { error: e.message }, status: :unauthorized
      end
    else
      render json: { error: 'Unauthorized User' }, status: :unauthorized
    end
  end
end
