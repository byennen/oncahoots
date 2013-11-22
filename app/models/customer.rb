class Customer < ActiveRecord::Base
  belongs_to :club
  belongs_to :user
  has_many :transactions, dependent: :destroy

  attr_accessible :stripe_id, :club_id, :user_id

  validates :user_id, uniqueness: {scope: :club_id}
  validates :stripe_id, presence: true

  def stripe_customer
    Stripe.api_key = club.stripe_credential.token
    Stripe::Customer.retrieve(stripe_id)
  end

  def last4
    stripe_customer.cards.first.last4
  end

  def charge!(item, quantity=1)
    amount = quantity.to_i*item.price*100
    Stripe.api_key = item.club.stripe_credential.token
    charge = Stripe::Charge.create({
      :amount => amount.to_i, # in cents
      :currency => "usd",
      :customer => stripe_id,
      :application_fee => (ENV["APPLICATION_FEE"].to_f*amount).to_i
      },
      item.club.stripe_credential.token
    )
    if charge
      trans = transactions.build(quantity: quantity, item_id: item.id, stripe_transaction_id: charge.balance_transaction)
      trans.save
    end
  end
end
