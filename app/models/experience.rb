class Experience < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :company_name, :date_ended, :date_started, :position_name
end
