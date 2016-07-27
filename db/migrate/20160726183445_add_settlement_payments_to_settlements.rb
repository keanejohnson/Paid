class AddSettlementPaymentsToSettlements < ActiveRecord::Migration
  def change
    create_table :settlement_payments do |t|
      t.belongs_to "user"
      t.belongs_to "settlement"
      t.float "settlement_amount"
      t.boolean "user_paid"
      t.boolean "debit"
    end
  end
end
