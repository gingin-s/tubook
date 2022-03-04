# テーブル設計

## usersテーブル

| Column                | Type           | Options                     |
|-----------------------|----------------|-----------------------------|
| email                 | string         | null: false, unique: true   |
| encrypted_password    | string         | null: false                 |
| nickname              | string         | null: false                 |
| account_name          | string         | null: false, unique: true   |


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
| text                  | text           | null: false                    |
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
| book                  | references     | null: false, foreign_key: true |
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
