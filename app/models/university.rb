class University < ActiveRecord::Base
  has_many :users
  has_many :updates, as: :updateable

  has_many :clubs, dependent: :destroy
  has_many :metropolitan_clubs, dependent: :destroy
  has_many :events, as: :eventable

  attr_accessible :location, :mascot, :name, :image, :banner, :slug

  mount_uploader :image, ImageUploader
  mount_uploader :banner, BannerUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  after_create :create_metropolitan_clubs

  private
    def create_metropolitan_clubs
      City.all.each do |city|
        metropolitan_clubs.create(city_id: city.id)
      end
    end
end
