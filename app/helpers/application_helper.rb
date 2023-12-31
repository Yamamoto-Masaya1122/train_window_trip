module ApplicationHelper
  def default_meta_tags
    {
      site: 'Train Window Trip',
      title: 'いつでもどこでも電車で旅行する体験ができるサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'Train Window Tripは電車で旅行する体験と美しい車窓のスポット情報を提供するサービスです。',
      keywords: '美しい車窓,車窓,電車',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('ogp.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
