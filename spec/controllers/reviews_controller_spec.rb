require "rails_helper"
require "reviews_controller"

# As a user
# I want to vote on a tutorial's review
# So that I can voice my opinion on its usefulness

describe ReviewsController, type: :controller do
  let(:review) { FactoryGirl.create(:review) }

  before(:each) do
    REDIS.flushdb
  end

  it "should upvote correctly", js: true do
    sign_in review.user
    post(:upvote, id: review.id, format: "json")
    expect(response.body).to eq "1"
    sign_in review.user
    post(:upvote, id: review.id, format: "json")
    expect(response.body).to eq "0"
  end

  it "should downvote correctly", js: true do
    sign_in review.user
    post(:downvote, id: review.id, format: "json")
    expect(response.body).to eq "-1"
    sign_in review.user
    post(:downvote, id: review.id, format: "json")
    expect(response.body).to eq "0"
  end
end
