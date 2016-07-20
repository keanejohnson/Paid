class ChangeUserColumnType < ActiveRecord::Migration
  def up
    change_column_null(:bills, :user_id, true)
  end

  def down
    change_column_null(:bills, :user_id, false)
  end
end
