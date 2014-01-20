class ClubPhoto < ActiveRecord::Base
  belongs_to :user
  belongs_to :album

  has_many :comments, as: :commentable, dependent: :destroy
  
  attr_accessible :image, :user_id, :caption, :featured

  validates :user_id, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  def self.by_user(user)
    where(user_id: user.id)
  end
end
