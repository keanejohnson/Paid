class Bill < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :group

  validates :title, presence: true
  validates :description,
    length: {
      maximum: 140,
      message: "Shorter description, please!"
    }
  validates :amount,
    presence: true,
    numericality: true,
    format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
  validates :party_size,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
end
