class User < ActiveRecord::Base
  has_many :bills, class_name: "Bill", foreign_key: "owner_id"
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :settlement_payments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
    presence: true,
    allow_nil: false,
    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
    uniqueness: true
end
