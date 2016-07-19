class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string "name", null: false
      t.belongs_to "user", null: false
      t.text "description"
      t.float "amount", null: false
      t.timestamps
    end
  end
end
