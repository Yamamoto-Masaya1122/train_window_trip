class VideosController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  include YoutubeApi

  def index
    @line = Line.find(params[:id])
    @search_results = Video.where(line_id: @line.id)
    @response = []

    if saved_and_recent?
      @search_results.each do |result|
        @response << {
          video_id: result.video_id, title: result.title, description: result.description,
          thumbnail: result.thumbnail, view_count: result.view_count, published_at: result.published_at.strftime("%Y/%m/%d")
        }
      end
    elsif saved_and_old?
      begin
        # Youtube APIから動画一覧を取得
        find_videos(@line.name)
        # 取得した動画一覧をDBに更新保存
        update_videos(@youtube_data, @search_results)
        # 取得した動画一覧をレスポンスで返す
        set_videos
      rescue StandardError
        @response = { error: ResourceNotFound }
      end
    else
      begin
        # Youtube APIから動画一覧を取得
        find_videos(@line.name)
        # 取得した動画をDBに保存
        save_videos(@youtube_data, params)
        # 取得した動画一覧をレスポンスで返す
        set_videos
      rescue StandardError
        @response = { error: ResourceNotFound }
      end
    end

    # ソート機能（閲覧数順、投稿日順）
    if params[:order_by_published_at]
      @response = sort_videos_by(@search_results, :published_at)
    elsif params[:order_by_view_count]
      @response = sort_videos_by(@search_results, :view_count)
    else
      # デフォルトのソート（投稿日の降順）
      @response = sort_videos_by(@search_results, :published_at)
    end
  end

  private

  # 動画を指定された属性でソートしてレスポンスを返すメソッド
  def sort_videos_by(videos, attribute)
    videos.order(attribute => :desc).map do |video|
      {
        video_id: video.video_id,
        title: video.title,
        description: video.description,
        thumbnail: video.thumbnail,
        view_count: video.view_count,
        published_at: video.published_at.strftime("%Y/%m/%d")
      }
    end
  end

  # 地点に関する動画を全て取得
  def set_videos
    @search_results = Video.where(line_id: @line.id)
    # 取得した動画一覧をレスポンスで返す
    @search_results.each do |result|
      @response << {
        video_id: result.video_id, title: result.title, description: result.description,
        thumbnail: result.thumbnail, view_count: result.view_count, published_at: result.published_at.strftime("%Y/%m/%d")
      }
    end
  end

  # 地点に関する動画をDBから取得できる & 動画が最近更新されている
  def saved_and_recent?
    @search_results.present? && @search_results.first.recently?
  end

  # 地点に関する動画をDBから取得できる & 動画が最近更新されていない
  def saved_and_old?
    @search_results.present? && !@search_results.first.recently?
  end
end
