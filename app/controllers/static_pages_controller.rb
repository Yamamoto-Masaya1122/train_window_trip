class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  before_action :crown_set

  def top
    @line_like_ranks = Line.find(Like.group(:line_id).order('count(line_id) DESC').limit(3).pluck(:line_id))
  
    @crown_rank = [] # 順位の配列
    last_like_count = nil # 前の行のいいね数を保存する変数
    rank = 1 # 実際の順位
    cnt = 1 # 同じ順位のカウント
  
    @line_like_ranks.each_with_index do |line, i|
      current_like_count = Like.where(line_id: line.id).count
  
      if last_like_count != current_like_count
        rank = cnt
      end
  
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
      '/images/five_crown05.png',
    ]
  end
end