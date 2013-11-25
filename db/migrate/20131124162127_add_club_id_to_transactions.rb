class AddClubIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :club_id, :integer
    add_column :transactions, :description, :string
  end
end
