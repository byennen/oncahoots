class City < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :users
  def slug
  	name.parameterize
  end

  mount_uploader :image, ImageUploader
end
