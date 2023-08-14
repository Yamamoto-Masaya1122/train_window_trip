class LineCategory < ApplicationRecord
  belongs_to :line
  belongs_to :category

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "line_id", "updated_at"]
  end
end
