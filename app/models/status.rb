class Status < ActiveRecord::Base
  attr_accessible :status

  belongs_to :club
  belongs_to :user

end
