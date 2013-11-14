class Interested < ActiveRecord::Base
  belongs_to :user
  belongs_to :interested_obj, polymorphic: true
  attr_accessible :interested_obj_id, :interested_obj_type

  validate :already_interested

  private
    def already_interested
      errors.add(:base, "already interested!") if user.interested_event?(interested_obj)
    end
end
