class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  has_many :club_photos

  attr_accessible :name, :location, :description, :club_photos_attributes

  validates :name, presence: true

  accepts_nested_attributes_for :club_photos, allow_destroy: true

  def featured
    club_photos.where(featured: true).first || club_photos.first
  end
end