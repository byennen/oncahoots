class Education < ActiveRecord::Base

  attr_accessible :completed, :major, :university, :degree_type, :graduation_year, :high_school

  belongs_to :profile

end
