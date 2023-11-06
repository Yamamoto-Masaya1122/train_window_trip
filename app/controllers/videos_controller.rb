class VideosController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_line, only: %i[index]
  before_action :set_search_results, only: %i[index]

  include YoutubeApi

  def index
    fetch_videos_if_needed
    # 動画を指定された属性でソートしてレスポンスを返すメソッド
    @response = sort_videos_by(sort_attribute)
  end

  private

  def fetch_videos_if_needed
    return if saved_and_recent?

    begin
      # Youtube APIから動画一覧を取得
      find_videos(@line.name)
      # 動画がDBに保存されてから10日以上経っている場合は更新処理する。DBに保存されていない動画の場合は保存処理する。
      saved_and_old? ? update_videos(@youtube_data, @search_results) : save_videos(@youtube_data, params)
    rescue StandardError
      @response = { error: ResourceNotFound }
    end
  end

  # パラメータの値がtrueなら:view_countを返す。falseなら:published_atを返す。
  def sort_attribute
    params[:order_by_view_count] ? :view_count : :published_at
  end

  def sort_videos_by(attribute)
    @search_results.order(attribute => :desc).map do |video|
      video_attributes(video)
    end
  end

  def video_attributes(video)
    {
      video_id: video.video_id,
      title: video.title,
      description: video.description,
      thumbnail: video.thumbnail,
      view_count: video.view_count,
      published_at: video.published_at.strftime("%Y/%m/%d")
    }
  end

  # 路線に関する動画をDBから取得できる & 動画が最近更新されている
  def saved_and_recent?
    @search_results.present? && @search_results.first.recently?
  end

  # 路線に関する動画をDBから取得できる & 動画が最近更新されていない
  def saved_and_old?
    @search_results.present? && !@search_results.first.recently?
  end

  # 路線に関する動画を全て取得
  def set_search_results
    @search_results = Video.where(line_id: @line.id)
  end

  def set_line
    @line = Line.find(params[:id])
  end
end
