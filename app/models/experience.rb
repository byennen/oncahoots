class Experience < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :company_name, :date_ended, :date_started, :position_name, :present

  def started
    date_started.strftime("%m/%d/%Y") if date_started
  end

  def ended
    date_ended.strftime("%m/%d/%Y") if date_ended
  end
end
