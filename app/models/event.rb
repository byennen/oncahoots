class Event < ActiveRecord::Base
  attr_accessible :title, :date, :time, :location, :description, :category,
                  :image, :free_food

  belongs_to :eventable, polymorphic: true

  mount_uploader :image, ImageUploader

  scope :free_food, where(free_food: true)
  scope :non_free_food, where(free_food: !true)

end
