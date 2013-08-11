class Update < ActiveRecord::Base
  attr_accessible :body, :image
  belongs_to :updateable, polymorphic: true

  mount_uploader :image, ImageUploader

end
