class TransactionsController < ApplicationController
  def index
    @club = Club.find(params[:club_id])
    @item = Item.new
    @items = @club.items
    @transactions = transactions_list
  end

  def create
    item = Item.find params[:transaction][:item_id]
    quantity = params[:transaction][:quantity] ||=1
    amount = quantity.to_i*item.price*100

    begin 
      customer = current_user.customer_of(item.club)
      Stripe.api_key = item.club.stripe_credential.token
      unless customer
        stripe_customer = Stripe::Customer.create(
          :card => params[:stripe_card_token],
          :description => current_user.email
        )
        customer = current_user.customers.create(club_id: item.club_id, stripe_id: stripe_customer.id)
      end
      if params[:update_card]
        stripe_customer = customer.stripe_customer
        stripe_customer.card = params[:stripe_card_token]
        stripe_customer.save
      end

      customer.charge!(item, quantity)

      redirect_to club_transactions_path(item.club), notice: "Transaction is created successfully"
    rescue
      redirect_to club_transactions_path(item.club), error: "There is something wrong while creating transaction"
    end

  end

  private
    def transactions_list
      if current_user.manage_club?(@club)
        return @club.transactions
      else
        return current_user.customer_of(@club).transactions
      end
    end
end