class Club < ActiveRecord::Base
  belongs_to :university

  attr_accessible :category, :description, :name, :university_id

  CLUB_TYPES = %w(Social Gender Media Performance Recreational Religious Service Student Govt. Team Sports Metropolitan)

end
