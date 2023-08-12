class Line < ApplicationRecord
  has_many :prefecture_lines
  has_many :prefectures, through: :prefecture_lines
  has_many :line_categories, dependent: :destroy
  has_many :categories, through: :line_categories
end
