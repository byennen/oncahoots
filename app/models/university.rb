class University < ActiveRecord::Base
  has_many :users
  has_many :updates, as: :updateable

  attr_accessible :location, :mascot, :name
end
