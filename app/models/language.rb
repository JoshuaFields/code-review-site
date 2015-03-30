class Language < ActiveRecord::Base
  has_many :tutorials
  has_many :reviews, through: :tutorials

  validates :language_name, presence: true
  validates :wikipedia_url, presence: true
end
