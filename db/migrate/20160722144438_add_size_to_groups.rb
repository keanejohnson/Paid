class AddSizeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :size, :integer, null: false
  end
end
