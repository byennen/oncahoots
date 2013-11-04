class Alert < ActiveRecord::Base

  attr_accessible :alertable_id, :alertable_type, :message

  validates :alertable_id, :alertable_type, :message, presence: true

end
