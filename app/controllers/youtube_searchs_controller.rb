require 'google/apis/youtube_v3'
require 'active_support/all'
class YoutubeSearchsController < ApplicationController

  def index
    # 動画検索に使う路線名とカテゴリをセット
    line_name =  "信楽高原鐵道" || " "
    category =  nil || " "
    # キーワードがタイトルと完全一致する動画のみを表示するために使う
    @keyword = "信楽高原鐵道" || " "
    @category = nil

    @youtube_data = find_videos(line_name, category)
  end
  
  def find_videos(keyword, category, after: 3.years.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    # Herokuにデプロイする用
    service.key = ENV['api_key']

    @youtube_data = []

    # 検索結果を取得
    search_results = service.list_searches(
      :snippet,
      type: "video",
      q: keyword + " " +  "前面展望" + " " + category,
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
