class Option < ActiveRecord::Base
  belongs_to :item
  attr_accessible :name, :value
end
