require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @note = FactoryBot.create(:note)
  end
  describe 'ノート新規作成' do
    context '新規作成できる場合' do
      it 'text・video_timeが存在すれば作成できる' do
        expect(@note).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'titleが空では作成できない' do
        @note.text = ''
        expect(@note.valid?).to eq(false)
      end
      it 'video_timeが空では作成できない' do
        @note.video_time = ''
        expect(@note.valid?).to eq(false)
      end
      it 'textが301文字以上では作成できない' do
        @note.text = Faker::Lorem.paragraph_by_chars(number: 301, supplemental: false)
        expect(@note.valid?).to eq(false)
      end
      it 'ユーザーが紐付いていないと作成できない' do
        @note.user_id = ''
        expect(@note.valid?).to eq(false)
      end
      it 'bookが紐付いていないと作成できない' do
        @note.book_id = ''
        expect(@note.valid?).to eq(false)
      end
    end
  end
end
