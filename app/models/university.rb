class University < ActiveRecord::Base
  has_many :users
  has_many :updates, as: :updateable

  has_many :clubs, dependent: :destroy
  has_many :metropolitant_clubs, dependent: :destroy
  has_many :events, as: :eventable

  attr_accessible :location, :mascot, :name, :image, :slug

  mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  after_create :create_metropolitant_clubs

  private
    def create_metropolitant_clubs
      City.all.each do |city|
        metropolitant_clubs.create(city_id: city.id)
      end
    end
end
