class SettlementPayment < ActiveRecord::Base
  belongs_to :settlement
  belongs_to :user

  delegate :bills, :group, to: :settlement
end
