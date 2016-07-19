class Bills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string "title", null: false
      t.text "description"
      t.float "amount", null: false
      t.integer "party_size", null: false
      t.belongs_to "user", null: false
      t.timestamps
    end
  end
end
