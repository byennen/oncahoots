class Customer < ActiveRecord::Base
  belongs_to :club
  belongs_to :user
  attr_accessible :stripe_id

  validates :user_id, uniqueness: {scope: :club_id}
  validates :stripe_id, presence: true

  def stripe_customer
    Stripe.api_key = "sk_test_9i5iZnZWUXtw41plXFDW1KuZ"
    Stripe::Customer.retrieve(stripe_id)
  end
end
