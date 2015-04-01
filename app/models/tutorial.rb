class Tutorial < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
  validates :language, presence: true
  validates :organization, presence: true

  has_many :reviews, dependent: :destroy
end
