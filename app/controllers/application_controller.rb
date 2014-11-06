class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, :alert => exception.message
  # end

  # rescue_from ActiveRecord::RecordNotFound do
  #   render_404
  # end

  # rescue_from StandardError, with: :render_500 unless Rails.env.development?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
  end

  private

  def after_sign_out_path_for(_resource)
    root_path
  end

  def after_sign_in_path_for(resource)
    events_path
  end

end
