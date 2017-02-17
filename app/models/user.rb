class User < ApplicationRecord
  has_secure_password
  has_many :letters, inverse_of: :owner, foreign_key: :owner_id
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_confirmation_of :password, on: :create
end
