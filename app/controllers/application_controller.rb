class ApplicationController < ActionController::Base
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
end
