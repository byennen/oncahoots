class University < ActiveRecord::Base
  has_many :users

  attr_accessible :location, :mascot, :name
end
