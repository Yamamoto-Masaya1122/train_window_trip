require 'google/apis/youtube_v3'
require 'active_support/all'
class YoutubeSearchsController < ApplicationController

  def index
    @youtube_data = find_videos(params[:format])
  end
  
  def find_videos(keyword, after: 4.years.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    # Herokuにデプロイする用
    service.key = ENV['api_key']
    # キーワードがタイトルと完全一致する動画のみを表示するために使う
    @keyword = keyword
    
    @youtube_data = []

    # 検索結果を取得
    search_results = service.list_searches(
      :snippet,
      type: "video",
      q: keyword + " " +  "前面展望",
      max_results: 24,
      # HD 動画のみ
      video_definition: "high",
      # 埋め込み可能な動画のみを検索
      video_embeddable: true,
      # 関連度が高い順
      order: "relevance",
      # 3年前より後のみ
      published_after: after.iso8601,
      # 本日より前のみ
      published_before: before.iso8601,
      fields: 'items(id(videoId), snippet(title, description, thumbnails(medium(url))))'
    )

    search_results.items.each_with_index do |item, index|
      video_id = search_results.items[index].id.video_id
      #動画の再生回数を取得する
      video_results = service.list_videos(
        :statistics,
        id: video_id,
        max_results: 1,
        fields: 'items(statistics(view_count))'
      )

      view_count = video_results.items[0].statistics.view_count
      snippet = item.snippet
      thumbnail = snippet.thumbnails.medium.url
      # { video_id・動画タイトル・概要・サムネ・再生回数 } を返す
      @youtube_data << { video_id: video_id, title: snippet.title, description: snippet.description, thumbnail: thumbnail, view_count: view_count }
    end
    return @youtube_data
  end
end