class TutorialsTag < ActiveRecord::Base
  belongs_to :tutorial
  belongs_to :tag
end
