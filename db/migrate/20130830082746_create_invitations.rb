class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :club_id
      t.string :token
      t.datetime :sent_at
      t.string :new

      t.timestamps
    end
  end
end
