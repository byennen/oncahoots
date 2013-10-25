class AddNameAndOrganizationNameAndImageAndDescriptionToPortfolioItems < ActiveRecord::Migration
  def change
    add_column :portfolio_items, :name, :string
    add_column :portfolio_items, :organization_name, :string
    add_column :portfolio_items, :image, :string
    add_column :portfolio_items, :description, :text
  end
end
