class Category < ApplicationRecord
  has_many :line_categories
  has_many :musics, through: :line_categories
end
