require "voting"

class ReviewsController < ApplicationController
  include ScoreHelper
  include Voting

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

  def upvote
    send_upvote(params[:id], current_user.id)
    respond_to do |format|
      format.json { render json: score(params[:id]) }
    end
  end

  def downvote
    send_downvote(params[:id], current_user.id)
    respond_to do |format|
      format.json { render json: score(params[:id]) }
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
