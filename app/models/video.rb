class Video < ApplicationRecord
  belongs_to :line

  # 10日以内に更新されたものか確認
  def recently?
    updated_at > Time.current.days_ago(10)
  end
end