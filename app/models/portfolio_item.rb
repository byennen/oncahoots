class PortfolioItem < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :file, :remote_file_url

  mount_uploader :file, PortfolioItemUploader
end
