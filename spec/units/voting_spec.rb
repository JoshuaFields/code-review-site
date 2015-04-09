require "rails_helper"
require "voting"
require "score_helper"
include Voting
include ScoreHelper

describe "Voting module and ScoreHelper" do
  context "ScoreHelper with no votes yet" do
    it "returns a score of 0" do
      expect(score("Q")).to eq "0"
    end
  end

  context "Test voting functionality" do
    it "successfully upvotes and removes upvote" do
      expect(send_upvote("P", "P")).to eq "OK"
      expect(score("P")).to eq "1"
      expect(send_upvote("P", "P")).to eq "OK"
      expect(score("P")).to eq "0"
    end

    it "successfully downvotes and removes downvote" do
      expect(send_downvote("P", "P")).to eq "OK"
      expect(score("P")).to eq "-1"
      expect(send_downvote("P", "P")).to eq "OK"
      expect(score("P")).to eq "0"
    end
  end
end
