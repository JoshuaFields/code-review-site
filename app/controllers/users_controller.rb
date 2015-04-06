class UsersController < ApplicationController
  def index
    @users = User.all
    unless current_user.admin?
      flash[:notice] = "This page requires admin privileges!"
      redirect_to tutorials_path
    end
  end
end
