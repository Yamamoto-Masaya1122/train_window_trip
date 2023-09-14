class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    Rails.logger.info "Broadcasting comment #{comment.id}"
    LineChannel.broadcast_to(comment.line, comment: render_comment(comment), second_comment: render_second_comment(comment), sender_id: comment.user_id)
  end

  private

  def render_comment(comment)
    ApplicationController.renderer.render(partial: 'comments/own_comment', locals: { comment: comment })
  end

  def render_second_comment(comment)
    ApplicationController.renderer.render(partial: 'comments/other_comment', locals: { comment: comment })
  end
end
