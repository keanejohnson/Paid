class Bill < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :description, length: { maximum: 140 }
  validates :amount,
              presence: true,
              numericality: true,
              format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
end
