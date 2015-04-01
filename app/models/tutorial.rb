class Tutorial < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
  validates :language, presence: true
  validates :organization, presence: true
  validates :user, presence: true

  belongs_to :user
  has_many :reviews, dependent: :destroy
end
