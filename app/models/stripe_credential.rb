class StripeCredential < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  attr_accessible :integer, :owner_id, :owner_type, :stripe_publishable_key, :token, :uid
end
