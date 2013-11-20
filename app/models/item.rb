class Item < ActiveRecord::Base
  belongs_to :club
  attr_accessible :description, :name, :price, :options_attributes
  has_many :options, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true

  validates :name, presence: true

  def display_price
    "$#{price}" if price
  end
end