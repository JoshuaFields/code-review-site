class Review < ActiveRecord::Base
  belongs_to :tutorial
  belongs_to :user

  validates :user, presence: true
  validates :tutorial, presence: true
  validates :body, length: { in: 3..8191 }, allow_blank: true
  validates :rating, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }
end
