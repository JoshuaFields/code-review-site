class Tutorial < ActiveRecord::Base
  has_many :tags, through: :tutorials_tags
  belongs_to :language

  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
end
