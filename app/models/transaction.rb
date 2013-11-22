class Transaction < ActiveRecord::Base
  belongs_to :item
  belongs_to :customer
  attr_accessible :customer_id, :item_id, :quantity, :stripe_transaction_id
end