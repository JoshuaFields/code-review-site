class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Should NOT destroy dependent reviews/tutorials when deleted.
  has_many :reviews
  has_many :tutorials


  def self.is_owner?(current_user, tutorial)
    tutorial.user == current_user
  end

  mount_uploader :profile_photo, ProfilePhotoUploader
end
