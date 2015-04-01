class Review < ActiveRecord::Base
  belongs_to :tutorial
  validates :body, presence: true, length: { in: 7..8191 }
  validates :rating, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }

  acts_as_votable

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
end
