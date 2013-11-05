class University < ActiveRecord::Base
  has_many :users
  has_many :updates, as: :updateable

  has_many :clubs, dependent: :destroy
  has_many :metropolitan_clubs, dependent: :destroy
  has_many :events, as: :eventable
  has_many :club_events, through: :clubs, source: :events

  attr_accessible :location, :mascot, :name, :image, :banner, :slug

  mount_uploader :image, ImageUploader
  mount_uploader :banner, BannerUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  def metropolitan_club(city_id)
    metropolitan_clubs.find_by_city_id city_id
  end

  after_create :create_metropolitan_clubs

  private
    def create_metropolitan_clubs
      City.all.each do |city|
        metropolitan_clubs.create(city_id: city.id)
      end
    end
end
