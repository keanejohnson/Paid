class UpdateBills < ActiveRecord::Migration
  def change
    rename_column :bills, :user_id, :owner_id
  end
end
