class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.belongs_to "user", null: false
      t.belongs_to "group", null: false
    end
  end
end
