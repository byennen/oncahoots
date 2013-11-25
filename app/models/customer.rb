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
    description = "#{self.user.email} charge for #{quantity}x#{item.name}"
    charge = charge(amount.to_i, item.club.stripe_credential.token, description)
    if charge
      trans = transactions.build(club_id: item.club_id, description: description, quantity: quantity, item_id: item.id, stripe_transaction_id: charge.id)
      trans.save
    end
  end

  def donate!(club, amount)
    description = "#{self.user.email} donate $#{amount} to #{club.name} club"
    charge = charge((amount.to_f*100).to_i, club.stripe_credential.token, description)
    if charge
      trans = transactions.build(club_id: club.id, description: description,stripe_transaction_id: charge.id)
      trans.save
    end
  end

  private
    def charge(amount, token, description)
      Stripe.api_key = token
      charge = Stripe::Charge.create({
        :amount => amount.to_i, # in cents
        :currency => "usd",
        :customer => stripe_id,
        :application_fee => (ENV["APPLICATION_FEE"].to_f*amount).to_i,
        :description => description
        },
        token
      )
    end
end
