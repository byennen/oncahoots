class Update < ActiveRecord::Base
  attr_accessible :headline, :body, :image, :user_id
  
  belongs_to :updateable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable

  mount_uploader :image, ImageUploader

  validates_presence_of :body
  validates_presence_of :headline
end
