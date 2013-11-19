class Item < ActiveRecord::Base
  belongs_to :club
  attr_accessible :description, :name, :price
  has_many :options, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true
end