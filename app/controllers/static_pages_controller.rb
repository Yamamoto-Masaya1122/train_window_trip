class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  before_action :crown_set

  def top
    @line_like_ranks = Line.find(Like.group(:line_id).order('count(line_id) DESC').limit(3).pluck(:line_id))

    @like_counts = @line_like_ranks.map { |line| Like.where(line_id: line.id).count }
    @like_count_max = @like_counts.max

    # 同率順位で表示されるようにする。
    @crown_rank = @like_counts.map do |count|
      case count
      when @like_count_max
        0 # 1位
      when @like_count_max - 1
        1 # 2位
      else
        2 # 3位
      end
    end
  end

  private

  def crown_set
    @crowns = [
      '/images/gold_crown.png',
      '/images/silver_crown.png',
      '/images/copper_crown.png',
    ]
  end
end