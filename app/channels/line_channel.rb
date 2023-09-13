class LineChannel < ApplicationCable::Channel
  def subscribed
    line = Line.find(params[:line_id])
    stream_for line
  end

  def unsubscribed
  end

  def speak(data)
    line = Line.find(data['line_id'])
    comment = line.comments.create!(body: data["comment"], user_id: current_user.id)
    
    LineChannel.broadcast_to(
      line, { comment: render_comment(comment) }
    )
  end

  private
  
  def render_comment(comment)
    ApplicationController.render(
      partial: "comments/comment",
      locals: { comment: comment }
    )
  end
end
