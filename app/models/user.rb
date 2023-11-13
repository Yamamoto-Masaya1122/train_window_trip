class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :lines, through: :likes
  has_many :rooms, dependent: :destroy
  has_many :comment_rooms, through: :comments, source: :room

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: { general: 0, admin: 1 }

  def unlikes_line(line)
    lines.destroy(line)
  end

  def line_like(line)
    lines << line
  end

  def liked_by?(line)
    lines.include?(line)
  end
end
