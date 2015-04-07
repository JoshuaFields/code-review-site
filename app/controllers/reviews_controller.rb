class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: %i(destroy)

  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @review = @tutorial.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      flash[:notice] = "Review Added."
      redirect_to tutorial_path(@tutorial)
    else
      flash[:notice] = @review.errors.full_messages.join("! ")
      render 'tutorials/show'
    end
  end

  def destroy
    @tutorial = Tutorial.find(params[:tutorial_id])
    @review = @tutorial.reviews.find(params[:id])
    @review.destroy
    redirect_to tutorial_path(@tutorial)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
