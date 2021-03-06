class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.update(admin: !@user.admin)
    redirect_to users_path
  end
end
