class Category < ApplicationRecord
  has_many :templates

  def self.with_templates
    joins(:templates).group("categories.id")
  end
end
