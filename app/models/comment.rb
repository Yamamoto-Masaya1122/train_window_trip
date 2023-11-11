class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room
  after_commit :broadcast_comment, on: [:create]

  validates :body, presence: true, length: { maximum: 65535}

  def broadcast_comment
    CommentBroadcastJob.perform_later(self)
  end
end
