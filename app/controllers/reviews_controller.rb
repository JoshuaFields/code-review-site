class ReviewsController < ApplicationController
  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @review = @tutorial.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review Added."
      redirect_to tutorial_path(@tutorial)
    else
      flash[:notice] = @review.errors.full_messages[0]
      render 'tutorials/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
