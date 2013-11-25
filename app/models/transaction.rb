class Transaction < ActiveRecord::Base
  belongs_to :club
  belongs_to :item
  belongs_to :customer
  attr_accessible :customer_id, :item_id, :quantity, :stripe_transaction_id, :club_id, :description

  def refundable?
    status == 'paid' && item_id
  end

  def refund!
    if refundable?
      charge = stripe_charge
      amount = charge.amount
      refund_amount = amount - amount*0.029 - 30 - amount*ENV["APPLICATION_FEE"].to_f
      charge.refund(amount: refund_amount.to_i)
      update_attribute :status, 'refunded'
    end
  end

  def stripe_charge
    Stripe.api_key = club.stripe_credential.token
    Stripe::Charge.retrieve(stripe_transaction_id)
  end
end