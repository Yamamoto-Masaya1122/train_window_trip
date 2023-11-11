class Room < ApplicationRecord
  belongs_to :line
  belongs_to :user
  has_many :users, through: :comments
  has_many :comments, dependent: :destroy

  validates :name, length: { maximum: 20 }, presence: true
end
