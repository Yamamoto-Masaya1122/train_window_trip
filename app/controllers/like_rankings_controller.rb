class LikeRankingsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :crown_set

  def index
    @line_like_ranks = Line.find(Like.group(:line_id).order('count(line_id) DESC').limit(5).pluck(:line_id))
    @crown_rank = [] # 順位の配列
    last_like_count = nil # 前の行のいいね数を保存する変数
    rank = 1 # 実際の順位
    cnt = 1 # ループが進むたびに順位をカウントアップするための変数

    @line_like_ranks.each do |line|
      current_like_count = Like.where(line_id: line.id).count
      rank = cnt if last_like_count != current_like_count #現在のいいね数と前のいいね数が異なる場合、rankをcntの値に更新
      @crown_rank.push(rank)
      last_like_count = current_like_count
      cnt += 1
    end
  end

  private

  def crown_set
    @crowns = [
      '/images/gold_crown01.png',
      '/images/silver_crown02.png',
      '/images/copper_crown03.png',
      '/images/four_crown04.png',
      '/images/five_crown05.png'
    ]
  end
end
