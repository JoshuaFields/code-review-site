class UsersController < ApplicationController
  def index
    @users = User.all
    unless current_user.admin?
      flash[:notice] = "This page requires admin privileges!"
      redirect_to tutorials_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin? && @user.destroy
      redirect_to users_path
    elsif current_user.admin?
      flash[:notice] = @tutorial.errors.full_messages.join("! ")
      render 'index'
    else
      flash[:notice] = "This page requires admin privileges!"
      redirect_to tutorials_path
    end
  end

  def toggle_admin
    @user = User.find(params[:id])
    if current_user.admin? && @user.update(admin: !@user.admin)
      redirect_to users_path
    elsif current_user.admin?
      flash[:notice] = @tutorial.errors.full_messages.join("! ")
      render 'index'
    else
      flash[:notice] = "This page requires admin privileges!"
      redirect_to tutorials_path
    end
  end
end
