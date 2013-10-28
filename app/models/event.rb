class Event < ActiveRecord::Base
  attr_accessible :title, :location, :description, :category,
                  :image, :free_food, :on_date, :at_time, :eventable_type, :club_id

  belongs_to :eventable, polymorphic: true

  mount_uploader :image, ImageUploader

  scope :free_food, where(free_food: true)
  scope :non_free_food, where(free_food: !true)

  validates :title, presence: true

  def date
    on_date.strftime("%Y-%m-%d") if on_date
  end

  def time
    at_time.strftime("%H:%M") if at_time
  end
end
