class AddBannerToUniversities < ActiveRecord::Migration
  def change
    add_column :universities, :banner, :string
  end
end
