class Tag < ActiveRecord::Base
  has_many :tutorials, through: :tutorials_tags

  validates :tag_name, presence:true
end
