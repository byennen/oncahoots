class Event < ActiveRecord::Base
  attr_accessible :eventable_id, :eventable_type, :name
end
