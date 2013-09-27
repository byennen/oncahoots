class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.integer :profile_id
      t.text :question
      t.text :answer
      t.timestamps
    end
  end
end
