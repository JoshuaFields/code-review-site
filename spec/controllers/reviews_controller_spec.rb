require "rails_helper"
require "reviews_controller"

describe ReviewsController, type: :controller do
  let(:review) { FactoryGirl.create(:review) }

  before(:each) do
    REDIS.flushdb
  end

  it "should upvote correctly", js: true do
    sign_in review.user
    post(:upvote, id: review.id, format: "json")
    expect(response.body).to include "1"
    sign_in review.user
    post(:upvote, id: review.id, format: "json")
    expect(response.body).to include "0"
  end

  it "should downvote correctly", js: true do
    sign_in review.user
    post(:downvote, id: review.id, format: "json")
    expect(response.body).to include "-1"
    sign_in review.user
    post(:downvote, id: review.id, format: "json")
    expect(response.body).to include "0"
  end
end
