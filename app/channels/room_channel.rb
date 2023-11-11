class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room_id])
    stream_for room
  end

  def unsubscribed; end

  def speak(data)
    room = Room.find(data['room_id'])
    body = data['comment'].strip # メッセージの前後の空白を削除
    return if body.blank? # メッセージが空でないことを確認
    # メッセージの作成だけ行い、ブロードキャストは after_commit フックに任せる
    room.comments.create!(body:, user_id: current_user.id)
    sleep(0.1)
  end
end
