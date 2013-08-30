class CreatePortfolioItems < ActiveRecord::Migration
  def change
    create_table :portfolio_items do |t|
      t.string :file
      t.integer :profile_id

      t.timestamps
    end
  end
end
