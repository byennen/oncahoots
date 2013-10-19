class University < ActiveRecord::Base
  has_many :users
  has_many :updates, as: :updateable
  has_many :clubs
  has_many :events, as: :eventable

  attr_accessible :location, :mascot, :name, :image, :slug

  mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :name, use: :slugged
end
