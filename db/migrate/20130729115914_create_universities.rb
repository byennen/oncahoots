class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.string :mascot
      t.string :location

      t.timestamps
    end
  end
end
