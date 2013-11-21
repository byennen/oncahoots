class TransactionsController < ApplicationController
  def index
    @club = Club.find(params[:club_id])
    @item = Item.new
    @items = @club.items
  end

  def create
    item = Item.find params[:transaction][:item_id]
    quantity = params[:transaction][:quantity] ||=1
    amount = quantity.to_i*item.price*100
    customer = current_user.customer
    begin 
      unless customer
        stripe_customer = Stripe::Customer.create(
          :card => params[:stripe_card_token],
          :description => current_user.email
        )
        customer = current_user.customers.create(club_id: item.club_id, stripe_id: stripe_customer.id)
      end
      if params[:update_card]
        stripe_customer = customer.stripe_customer.card = params[:stripe_card_token]
        stripe_customer.save
      end

      Stripe::Charge.create(
        :amount => amount, # in cents
        :currency => "usd",
        :customer => customer.stripe_id
      )
      redirect_to club_transactions_path(item.club), notice: "Transaction is created successfully"
    rescue Exception => e
      logger.info(e.message)
      redirect_to club_transactions_path(item.club), error: "There is something wrong when creating transaction"
    end

  end

end