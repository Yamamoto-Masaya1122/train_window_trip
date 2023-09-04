# train_window_trip
### ■サービス概要

- いつでもどこでも電車で旅行する体験ができるアプリです。
- その日の気分によって美しい車窓の景色動画を視聴できます。
- このアプリを使うことで美しい車窓のスポットなどの情報を得ることができます。

### ■ユーザーが抱える課題

- 電車から見える景色をゆっくり見たいが車内が混雑していて座席に座ってゆっくり見れない。
- 秘境地域を走る路線の車窓は直接見に行きずらい。
- 友達や誰かと一緒に旅行してる時にゆっくり景色を見れない。
- 車窓の美しい景色に関する情報が不足している。

### ■課題に対する仮説

- 都道府県、路線名、季節、風景を検索条件にしてそれにヒットする車窓情報を一覧で表示することで、見たい景色の情報に簡単に辿りつけるのでは？
- Youtubeの前面展望動画を活用することでいつでもどこでも車窓の風景を楽しめるのではないか？

### ■解決方法

- 地域・路線名・風景の条件を選択して絞り込み検索ができるようにする。
- Youtube上にある高画質の前面展望動画をユーザーに見てもらう。

### ■メインのターゲットユーザー

- 車窓からの景色を元々楽しんでいる人
- 電車で旅行するのが好きな人

### ■実装予定の機能（以下の例は実際のアプリの機能から一部省略しています）

**非登録ユーザー**

1. 前面展望動画の再生機能
    - ユーザーは電車の前面展望動画を見ることができる。
2. 路線検索機能
    - 都道府県から路線を検索することができる。(セレクトボックス)
    - 桜、雪、紅葉や海、山、湿原、夜景、川といったカテゴリで路線を検索することができる。
    
    都道府県を選択した際に、その都道府県を通る路線だけを選択できるようにすることで、電車に詳しくない人でも簡単に路線を選べるようにする。
    
3. 路線詳細機能
    - 各路線のホームページのURLを載せることで沿線の観光情報を得ることができる。
    - おすすめの車窓スポットを知ることができる。（〇〇駅〜〇〇駅が絶景ポイントです。のような）
    - 各路線の概要(特徴)を知ることができる。
4. ランキング機能
    - お気に入り登録された数で路線を順位づけをして、人気の路線を知ることができる。
5. ユーザー登録機能
    - 新規ユーザー作成
    - ログイン機能

**登録ユーザー**

1. マイページ機能
    - 登録しているユーザー情報（名前とメールアドレス）を編集、更新することができる。
    - お気に入り登録した路線を表示することができる。
2. お気に入り登録
    - ユーザーはお気に入りの路線を登録することができる。
3. コメント機能
    - 各路線に対してコメントをすることができる。 ユーザーがおすすめする車窓や観光スポットや沿線沿いにあるグルメスポットなどを他のユーザーと共有することができます。(コメント投稿の部分はリアルタイム通信)

**管理者ユーザー**

- 登録ユーザーの一覧・詳細・編集・削除することができる
- 管理ユーザーの一覧・詳細・作成・編集することができる
- コメントを一覧・詳細・削除することができる

### ■なぜこのサービスを作りたいのか？

幼少期から車窓から見える景色が大好きで、特に知らない街や景色を見て新たな発見をすることにワクワク感を抱いています。今でもリフレッシュのためによく一人で電車に乗って旅行しています。また、遠くに行けない場所などは前面展望動画を見ることで旅行気分を味わっています。ただ、美しい車窓の情報を探すのが困難でした。インターネットで検索しても、「まとめサイト」や「各鉄道会社のウェブサイト」しか見つからず、地域やカテゴリごとに情報を探すのが難しいと感じていました。

また、仕事中に見ていた石切〜額田間の景色は、大阪平野が広がっていて本当に美しく私のお気に入りのスポットでしたが、その景色が地元の人々にしか知られていない現実にも直面しました。

そこで、YouTubeにある「前面展望動画」を活用し、実際に電車に乗っているかのような体験を提供することで、多くの人に車窓から見える景色の素晴らしさを知り、実際に足を運んでもらえる様なアプリを作ろうと考えました。

### ■スケジュール

- 企画〜技術調査：6/26〆切
- README〜ER図作成：7/7 〆切
- メイン機能実装：7/8 - 9/8
- β版をRUNTEQ内リリース（MVP）：9/8〆切
- 本番リリース：9月末

### ■主な使用技術
- Ruby 3.2.2
- Rails 7.0.6
- JavaScript
- Hotwire(Turbo)
- Tailwind css
- daisyUI
- postgresql
- Heroku
- Acctioncableを用いたチャット機能
- Youtube Date API

### ■画面遷移図
https://www.figma.com/file/PxMecqG2lpliznWe9NxGPF/Train-Window-View?type=design&node-id=0%3A1&mode=design&t=y3qClG9dKz7qz4j9-1

### ■ER図
[![Image from Gyazo](https://i.gyazo.com/27a331c0dfee97d96b8e78067a3fa9b5.png)](https://gyazo.com/27a331c0dfee97d96b8e78067a3fa9b5)