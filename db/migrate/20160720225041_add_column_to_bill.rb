class AddColumnToBill < ActiveRecord::Migration
  def change
    add_column :bills, :group_id, :integer
  end
end
