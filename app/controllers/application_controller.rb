class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authorize_admin!
    unless current_user.try(:admin?)
      flash[:notice] = "This page requires admin privileges!"
      redirect_to tutorials_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :profile_photo
    devise_parameter_sanitizer.for(:account_update) << :profile_photo
  end
end
