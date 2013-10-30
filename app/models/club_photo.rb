class ClubPhoto < ActiveRecord::Base
  belongs_to :club
  belongs_to :user

  attr_accessible :image, :club_id, :user_id

  validates :user_id, presence: true
  validates :club_id, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  def self.by_user(user)
    where(user_id: user.id)
  end
end
