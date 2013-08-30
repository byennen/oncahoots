class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :club

  attr_accessible :admin, :manager, :club_id, :user_id

end
