class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :bills

  validates :name, presence: true
  validates :size,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
end
