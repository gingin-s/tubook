# アプリケーション名
Tubook


# アプリケーション概要
youtube動画での学習を支援するアプリケーションです。  
</br>
好みのyoutube動画にタイトルを付けて管理することができ、参考書に付箋を貼るような感覚で指定した時間にメモを書き込めます。  
メモをクリックすると、メモのある時間に動画をジャンプさせることができるので、いつでも・簡単に・素早く知りたい情報にたどり着くことができます。  
また、書き込んだメモは動画の再生に合わせて表示されます。  
これらの機能により作成されるコンテンツをアプリ内では本になぞらえ、Bookと呼びます。
</br>
</br>
その他に、任意のメンバーを招待できるRoom機能では作成したBookを共有することができ、また、リアルタイムチャットを使ってアプリケーション内で簡単にコミュニケーションを取ることができます。  
これらの機能は、学習のみならず、動画制作における制作物の確認や修正点の共有といった利用も想定して実装しました。  

# URL
http://52.198.247.103/

# テスト用アカウント
- basic認証ID: admin
- basic認証パスワード: 2222  
### ゲストアカウント
- ゲスト1
  - メールアドレス: g1@sample.com
  - パスワード: aaa222
- ゲスト2
  - メールアドレス: g2@sample.com
  - パスワード: aaa222  

### その他ルーム招待用アカウント名
- tanaka
- suzuki
- GINGIN


# 利用方法
### Book作成
① ヘッダー右のユーザーアイコンをクリックし、プルダウンリストから「＋新規Book」をクリックします。
<img width="1440" alt="新規Book1" src="https://user-images.githubusercontent.com/98451976/160044989-6f9e3a69-f1e1-4ce3-b5d7-f6fd558365f9.png">


② BookにしたいYouTubeの動画URLを貼り付けます。（必須）  
③ Bookのタイトルを入力します。（必須）  
④ 概要を入力します。（必須）  
⑤ 「新規Bookを開く」の横の本のアイコンを押します。  
<img width="1436" alt="新規Book2" src="https://user-images.githubusercontent.com/98451976/159932410-bda2f693-a6b2-4314-8719-0de3dc9bc4fa.png">


### Book表示・Note追加
① Noteの追加フォームでは、ペンのアイコンをクリックで動画の時間を取得し、Noteを入力した後「送信」ボタンを押すことでテキストをNotesに追加することができます。  
②「Now:」ディスプレイには、現在の動画の再生時間に合わせて登録されたNoteが表示されます。  
③ Notesウィンドウに表示されているNoteの時間リンクをクリックすることで、動画をNoteの時間にジャンプさせることができます。  
④ Noteのテキストをクリックすると、編集・削除ボタンが表示されます。「編集」を押すと、Noteの追加フォームが編集モードに切り替わります。「削除」を押すと、対象のNoteが削除されます。  
<img width="1440" alt="Book表示" src="https://user-images.githubusercontent.com/98451976/159937832-4bd130c1-44e5-4bc0-8c0e-a4d6fa024965.png">


### Roomの作成
① ヘッダー右のユーザーアイコンをクリックし、プルダウンリストから「＋新規Room」をクリックします。  
<img width="1440" alt="Room作成１" src="https://user-images.githubusercontent.com/98451976/160045093-fd746f06-e10c-4206-9e11-5d58b9cff37b.png">  

② Roomの名前を入力します（必須）  
③追加したいメンバーのアカウント名を入力し、＋アイコンをクリックすると、④のmembersに追加されます。  
④メンバーの追加が終わったら、⑤のドアのアイコンをクリックします。  
<img width="1440" alt="Room作成２" src="https://user-images.githubusercontent.com/98451976/159940745-ae787d0e-86db-4c1d-b6b3-3249802809c0.png">


### Room内の操作
① ルームメンバーの追加や削除などの管理が行なえます。  
② サイドバー内で、ルームメンバーとのリアルタイムグループチャットが行なえます。  
<img width="1440" alt="Room内操作" src="https://user-images.githubusercontent.com/98451976/159942587-40a98095-3dbb-49a2-867d-1b7203e913c1.png">  

<img width="1440" alt="チャット画面" src="https://user-images.githubusercontent.com/98451976/160086074-3c67c603-6442-44a6-9c87-c09fd5e405a0.png">


# アプリケーションを作成した背景
私の身近な友人や同僚にヒアリングを行ったところ、「近頃は動画で学習を行うことが多いが、復習をするときに必要な情報を素早く取り出すことができない」というケースに遭遇しました。  
これには私自身も見に覚えがあり、ちょうど動画を扱ってみたいとも考えていたので「動画を扱いやすくする」というテーマに取り組もうと考えました。  
さらにヒアリングを続けたところ、仕事の一環で動画制作を行うという知人から、「作成した動画の修正箇所等の伝達・コミュニケーションがスムーズにいかない」という問題を知りました。  
そこで、  
1. 動画の必要な情報を、引き出しやすい状態でまとめておく  
2. これをチームで共有し、コミュニケーションを取りやすくする  

以上の2点の要件を満たすアプリを開発することにしました。  

# 洗い出した要件
[要件を定義したシート](https://docs.google.com/spreadsheets/d/1ZGgOb8gLNWWtdCkiKWB1LL8trbz3seHkq_8_9xNS6Ig/edit#gid=982722306)


# 実装予定の機能
- Noteに投稿者のアカウント名を表示  
- Bookにラベル機能を搭載し、Book一覧ページで選択したラベルごとの表示を可能にする  
- パンくずリスト、もしくは遷移先のわかりやすいリンクの作成  
- Room一覧にRoomアバターを表示する  
- chatのメッセージに投稿時刻表示を追加する  
- お知らせ機能  


# 画面遷移図
<img width="1242" alt="画面遷移図" src="https://user-images.githubusercontent.com/98451976/160046120-ee3419df-8aeb-44f7-813e-cf2db39fc0d4.png">


# データベース設計
<img width="1045" alt="ER図" src="https://user-images.githubusercontent.com/98451976/160046086-2a311a86-21df-4f24-a78c-adf255601cb0.png">

# テーブル設計

## usersテーブル

| Column                | Type           | Options                     |
|-----------------------|----------------|-----------------------------|
| email                 | string         | null: false, unique: true   |
| encrypted_password    | string         | null: false                 |
| nickname              | string         | null: false  unique: true   |


### Association

- has_many :notes
- has_many :chat_messages
- has_many :book_users
- has_many :room_users
- has_many :books, through: :book_users
- has_many :rooms, through: :room_users

## booksテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| title                 | string         | null: false                    |
| description           | text           |                                |
| youtube_id            | string         | null: false                    |


### Association

- has_many :notes
- has_many :chat_messages
- belongs_to :user
- belongs_to :room

## roomsテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| name                  | string         | null: false                    |

### Association

- has_many :book_users
- has_many :room_users
- has_many :books, through :book_users
- has_many :users, through :room_users

## notesテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| text                  | string         | null: false                    |
| video_time            | integer        | null: false                    |
| book                  | references     | null: false, foreign_key: true |
| user                  | references     | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :book


## chat_messagesテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| text                  | text           | null: false                    |
| room                  | references     | null: false, foreign_key: true |
| user                  | references     | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :book

## book_roomsテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| book                  | references     | null: false, foreign_key: true |
| room                  | references     | null: false, foreign_key: true |

### Association

- belongs_to :book
- belongs_to :room

## book_usersテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| book                  | references     | null: false, foreign_key: true |
| user                  | references     | null: false, foreign_key: true |

### Association

- belongs_to :book
- belongs_to :user

## room_usersテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| room                  | references     | null: false, foreign_key: true |
| user                  | references     | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

# 開発環境
- フロントエンド
  - HTML/CSS
  - JavaScript
- バックエンド
  - Ruby 2.6.5
  - Ruby on Rail 6.0.0
- インフラ
  - AWS
    - EC2
    - mariaDB
    - S3
- テスト
  - Rspec
