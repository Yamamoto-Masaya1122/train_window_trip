class Line < ApplicationRecord
  has_many :prefecture_lines, dependent: :destroy
  has_many :prefectures, through: :prefecture_lines
  has_many :line_categories, dependent: :destroy
  has_many :categories, through: :line_categories
  has_many :comments, dependent: :destroy
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "image", "line_url", "name", "recommended_train_window_spot", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "line_categories", "prefecture_lines", "prefectures"]
  end

end
