class PortfolioItem < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :image, :remote_image_url, :name, :organization_name, :description

  mount_uploader :image, PortfolioItemUploader
end
