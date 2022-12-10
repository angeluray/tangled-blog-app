class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Response
  include ExceptionHandler

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @user_id = params[:user_id]
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: "JWT_ error: #{e.message}" }, status: :unauthorized
    else
      render json: { errors: 'Missing token' }, status: :unauthorized unless @decoded
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email photo bio password current_password])
  end
end
