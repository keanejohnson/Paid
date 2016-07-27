class AddSettlementToBill < ActiveRecord::Migration
  def change
    add_column :bills, :settlement_id, :integer
  end
end
