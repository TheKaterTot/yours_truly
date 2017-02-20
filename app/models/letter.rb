class Letter < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :shared_letters
  has_many :users, through: :shared_letters
  validates_presence_of :content
end
