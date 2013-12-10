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
      send_message(trans)
    end
  end

  def donate!(club, amount)
    description = "#{self.user.email} donate $#{amount} to #{club.name} club"
    charge = charge((amount.to_f*100).to_i, club.stripe_credential.token, description)
    if charge
      trans = transactions.build(club_id: club.id, description: description,stripe_transaction_id: charge.id)
      trans.save
      send_donate_message(trans, amount)
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

    def send_message(transaction)
      club = transaction.club
      item = transaction.item
      title = "Receipt for transaction at club #{club.name}"
      date_time = "<br>DateTime: #{transaction.created_at.strftime('%m/%d/%y %H:%M')}<br>"
      item_name = "<br>Item: #{item.name}<br>"
      price = "Price: $#{item.price}<br>"
      quantity = "Quantity: #{transaction.quantity}<br>"
      total = "<strong>Total: $#{transaction.quantity.to_i * item.price}</strong>"
      content = title + date_time + item_name + price + quantity + total
      club.send_message(user, content.html_safe, title)
      title = "Receipt for transaction at club #{club.name}"
      title1 = "<br>#{user.name}(#{user.email}) has a transaction at club #{club.name}"
      content = title + title1 + date_time + item_name + price + quantity + total
      club.send_message(club.leaders.all, content.html_safe, title)
    end

    def send_donate_message(transaction, amount)
      club = transaction.club
      title = "Donation Receipt"
      title1 = "<br>You have donate an amount of $#{amount} at #{club.name} club<br>"
      date_time = "DateTime: #{transaction.created_at.strftime('%m/%d/%y %H:%M')}"
      content = title + title1 + date_time
      club.send_message(user, content.html_safe, title)
      title1 = "<br>#{user.name}(#{user.email}) have donate an amount of $#{amount} at #{club.name} club<br>"
      content = title + title1 + date_time
      club.send_message(club.leaders.all, content.html_safe, title)
    end
end
