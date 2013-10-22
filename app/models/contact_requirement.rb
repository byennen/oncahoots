class ContactRequirement < ActiveRecord::Base

  attr_accessible :gpa_requirement, :major_requirement,
                  :years_working_experience, :fields_of_interest

  belongs_to :profile

end
