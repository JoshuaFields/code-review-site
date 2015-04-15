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
      ReviewNotifier.new_review(@review).deliver_later
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
    vote("up", "down")
  end

  def downvote
    vote("down", "up")
  end

  private

  def vote(vote, opposite)
    send_vote(params[:id], current_user.id, vote, opposite)
    respond_to { |format| format.json { render json: score(params[:id]) } }
  end

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
