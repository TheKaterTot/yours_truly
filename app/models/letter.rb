class Letter < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  validates_presence_of :content
end
