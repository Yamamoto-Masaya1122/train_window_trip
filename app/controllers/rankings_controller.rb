class RankingsController < ApplicationController
  before_action :require_login
  before_action :crown_set

  def index
    @line_like_ranks = load_rankings
    calculate_crown_rank(@line_like_ranks) unless params[:season] == 'likes'
  end

  private

  def load_rankings
    case params[:season]
    when 'spring'
      calculate_rankings('桜')
    when 'autumn'
      calculate_rankings('紅葉')
    when 'winter'
      calculate_rankings('雪')
    else
      Line.joins(:likes)
          .group('lines.id')
          .select('lines.*, COUNT(likes.id) AS likes_count')
          .order('likes_count DESC')
          .limit(5)
    end
  end

  def calculate_rankings(category_name)
    category = Category.find_by(name: category_name)
    line_ranks = Line.joins(:line_categories, :likes)
                     .where(line_categories: { category_id: category.id })
                     .group('lines.id')
                     .select('lines.*, COUNT(likes.id) AS likes_count')
                     .order('likes_count DESC')
                     .limit(5)
    calculate_crown_rank(line_ranks)
  end

  def calculate_crown_rank(line_ranks)
    @crown_rank = []
    last_like_count = nil
    rank = 1
    cnt = 1

    line_ranks.each do |line|
      current_like_count = line.likes_count
      rank = cnt if last_like_count != current_like_count
      @crown_rank.push(rank)
      last_like_count = current_like_count
      cnt += 1
    end
  end

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
