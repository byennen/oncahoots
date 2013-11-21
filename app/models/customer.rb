class Customer < ActiveRecord::Base
  belongs_to :club
  belongs_to :user
  attr_accessible :stripe_id, :club_id, :user_id

  validates :user_id, uniqueness: {scope: :club_id}
  validates :stripe_id, presence: true

  def stripe_customer
    Stripe::Customer.retrieve(stripe_id)
  end

end
