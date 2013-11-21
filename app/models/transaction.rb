class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :item_id, :quantity, :stripe_transaction_id
end
