class PortfolioItem < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :image, :remote_image_url, :name, :organization_name, :description

  mount_uploader :image, PortfolioItemUploader

  before_save :deny_duplicate

  private
  def deny_duplicate
    !PortfolioItem.exists?(profile_id: profile_id, name: name, organization_name: organization_name, description: description)
  end
end
