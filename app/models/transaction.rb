class Transaction < ActiveRecord::Base
  belongs_to :club
  belongs_to :item
  belongs_to :customer
  attr_accessible :customer_id, :item_id, :quantity, :stripe_transaction_id, :club_id, :description
end