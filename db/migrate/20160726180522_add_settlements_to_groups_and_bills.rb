class AddSettlementsToGroupsAndBills < ActiveRecord::Migration
  def change
    create_table :settlements do |t|
      t.belongs_to "group"
      t.boolean "complete"
      t.float "average_payment"
      t.timestamps
    end
  end
end
