class Tag < ActiveRecord::Base
  has_many :tutorials_tags
  has_many :tutorials, through: :tutorials_tags
end
