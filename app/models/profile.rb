class Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :user_id, :education, :experience, :skills
end
