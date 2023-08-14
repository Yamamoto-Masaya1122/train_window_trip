class PrefectureLine < ApplicationRecord
  belongs_to :prefecture
  belongs_to :line

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "line_id", "prefecture_id", "updated_at"]
  end
end
