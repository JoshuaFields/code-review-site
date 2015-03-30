class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :tutorial

  validates :tutorial

  validates :rating, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :vote_tally, presence: true
end
