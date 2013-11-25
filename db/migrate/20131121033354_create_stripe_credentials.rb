class CreateStripeCredentials < ActiveRecord::Migration
  def change
    create_table :stripe_credentials do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :stripe_publishable_key
      t.string :token
      t.string :uid

      t.timestamps
    end
  end
end
