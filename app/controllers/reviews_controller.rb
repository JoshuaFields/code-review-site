class ReviewsController < ApplicationController
  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @review = @tutorial.reviews.new(review_params)
    if @review.save
      redirect_to tutorial_path(@tutorial)
    else
      render 'tutorials/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
