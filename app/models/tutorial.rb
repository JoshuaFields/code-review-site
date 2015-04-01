class Tutorial < ActiveRecord::Base
  validates :title, presence: true, length: { in: 3..255 }
  validates :url, presence: true, length: { in: 4..511 }
  validates :language, presence: true, length: { in: 1..127 }
  validates :organization, length: { in: 3..127 }, allow_blank: true
  validates :description, length: { in: 7..4095 }, allow_blank: true
  validates :cost, allow_blank: true, inclusion: { in: %w(Free $ $$ $$$ $$$$) }
  validates :user, presence: true

  belongs_to :user
  has_many :reviews, dependent: :destroy
end
