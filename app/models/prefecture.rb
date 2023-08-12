class Prefecture < ApplicationRecord
  has_many :prefecture_lines, dependent: :destroy
  has_many :lines, through: :prefecture_lines
end
