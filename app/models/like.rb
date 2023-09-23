class Like < ApplicationRecord
  belongs_to :user
  belongs_to :line

  validates :user_id, uniqueness: { scope: :line_id }
end
