class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :nope, if: :sign_up_request?
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :flash_to_headers

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do
    render_404
  end

  rescue_from StandardError, with: :render_500 unless Rails.env.development?

  def flash_to_headers
    return unless request.xhr?
    # response.headers['X-Message'] = flash[:error]  unless flash[:error].blank?
    # repeat for other flash types...

    flash.discard  # don't want the flash to appear when you reload page
  end

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

  def sign_up_request?
    controller_name == 'registrations' && action_name == 'new'
  end

  def nope
    flash[:error] = 'Nope!'
    redirect_to root_url
  end

  # 500 Internal Server Error
  def render_500
    respond_to do |type|
      type.html { render template: 'shared/500', layout: 'errors', status: :not_found }
      type.all  { render nothing: true, status: :internal_server_error }
    end
  end

  # 404 Not Found
  def render_404
    respond_to do |type|
      type.html { render template: 'shared/404', layout: 'errors', status: :not_found }
      type.all  { render nothing: true, status: :not_found }
    end
  end

  # 401 Unauthorized
  def render_401
    respond_to do |type|
      type.html { render template: 'shared/401', layout: 'errors', status: :unauthorized }
      type.all  { render nothing: true, status: :unauthorized }
    end
  end
end
