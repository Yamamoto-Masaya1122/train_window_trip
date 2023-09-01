class Category < ApplicationRecord
  has_many :line_categories, dependent: :destroy
  has_many :lines, through: :line_categories
end
