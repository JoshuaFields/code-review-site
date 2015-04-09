class TutorialsTag < ActiveRecord::Base
  validates :tutorial, presence: true
  validates :tag, presence: true

  belongs_to :tutorial
  belongs_to :tag
end
