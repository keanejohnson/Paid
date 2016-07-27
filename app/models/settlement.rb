class Settlement < ActiveRecord::Base
  has_many :bills
  has_many :settlement_payments
  belongs_to :group

  def calc_average_payment
    update_attributes(average_payment: bills.sum(:amount) / group.size.to_f)
  end
end
