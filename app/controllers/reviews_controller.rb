class ReviewsController < ApplicationController
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

  def downvote
    @review = Review.find(params[:id])
    @review.downvote_by current_user
    @tutorial = @review.tutorial
    redirect_to tutorial_path(@tutorial)
  end

  def upvote
    @review = Review.find(params[:id])
    @review.upvote_by current_user
    @tutorial = @review.tutorial
    redirect_to tutorial_path(@tutorial)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
