class Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :education, :experience, :skills
end
