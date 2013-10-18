class AddRecommendedByIdToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :recommended_by_id, :integer
  end
end
