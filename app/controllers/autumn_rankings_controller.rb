class AutumnRankingsController < ApplicationController
  before_action :require_login
  before_action :crown_set

  def index
    category = Category.find_by(name: '紅葉')
    @line_autumn_like_ranks = Line.joins(:line_categories, :likes)
                                  .where(line_categories: { category_id: category.id })
                                  .group('lines.id')
                                  .select('lines.*, COUNT(likes.id) AS likes_count')
                                  .order('likes_count DESC')
                                  .limit(5)
    @crown_rank = [] # 順位の配列
    last_like_count = nil # 前の行のいいね数を保存する変数
    rank = 1 # 実際の順位
    cnt = 1 # ループが進むたびに順位をカウントアップするための変数

    @line_autumn_like_ranks.each do |line|
      current_like_count = line.likes_count
      rank = cnt if last_like_count != current_like_count # 現在のいいね数と前のいいね数が異なる場合、rankをcntの値に更新
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
