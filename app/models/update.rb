class Update < ActiveRecord::Base

  attr_accessible :headline, :body, :image
  
  belongs_to :updateable, polymorphic: true

  has_many :comments, as: :commentable

  mount_uploader :image, ImageUploader

end
