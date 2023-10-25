class LikeRankingsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :crown_set

  def index
    @line_like_ranks = Line.find(Like.group(:line_id).order('count(line_id) DESC').limit(5).pluck(:line_id))

    @like_counts = @line_like_ranks.map { |line| Like.where(line_id: line.id).count }
    @like_count_max = @like_counts.max

    # 同率順位で表示されるようにする。
    @crown_rank = @like_counts.map do |count|
      case count
      when @like_count_max
        0 # 1位
      when @like_count_max - 1
        1 # 2位
      when @like_count_max - 2
        2 # 3位
      when @like_count_max - 3
        3 # 4位
      else
        4 # 5位
      end
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
