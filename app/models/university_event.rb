class UniversityEvent < ActiveRecord::Base
  attr_accessible :category, :club_id, :date, :description, :image, :location, :time, :title
end
