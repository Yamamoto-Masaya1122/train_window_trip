class Prefecture < ApplicationRecord
  has_many :prefecture_lines, dependent: :destroy
  has_many :lines, through: :prefecture_lines

  def self.ransackable_attributes(*)
    ["created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(*)
    ["lines", "prefecture_lines"]
  end
end
