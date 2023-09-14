class LineChannel < ApplicationCable::Channel
  def subscribed
    line = Line.find(params[:line_id])
    stream_for line
  end

  def unsubscribed
  end

  def speak(data)
    line = Line.find(data['line_id'])
    body = data['comment'].strip # メッセージの前後の空白を削除
    return unless body.present? # メッセージが空でないことを確認

    # メッセージの作成だけ行い、ブロードキャストは after_commit フックに任せる
    comment = line.comments.create!(body:, user_id: current_user.id)
    sleep(0.1)
  end
end
