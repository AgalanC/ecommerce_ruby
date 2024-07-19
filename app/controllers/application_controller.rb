class ApplicationController < ActionController::Base
  # before_action :authenticate_user! # Ensure user is logged in
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :address, :province])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :address, :province])
  end
end
