class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :relation_id
      t.text :message
      t.string  :status
      t.datetime :accepted_at
      t.timestamps
    end
  end
end
