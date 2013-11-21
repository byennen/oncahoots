class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :item_id
      t.integer :quantity
      t.integer :customer_id
      t.string :stripe_transaction_id

      t.timestamps
    end
  end
end
