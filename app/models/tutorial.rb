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
  has_many :tutorials_tags
  has_many :tags, through: :tutorials_tags

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(tag_name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:tag_name).join(", ")
  end

  def self.tagged_with(tag_name)
    Tag.find_by_tag_name!(tag_name).tutorials
  end
end
