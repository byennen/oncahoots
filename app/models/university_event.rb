class UniversityEvent < ActiveRecord::Base
  attr_accessible :title, :date, :time, :location, :description, :category,
                  :image

  belongs_to :club
  has_many :events, as: :eventable
end
