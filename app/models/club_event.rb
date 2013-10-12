class ClubEvent < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title, :date, :time, :location, :description, :category,
                  :image

  belongs_to :club
  has_many :events, as: :eventable

  mount_uploader :image, ImageUploader

end
