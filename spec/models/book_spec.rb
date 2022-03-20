require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
  end
  describe 'ブック新規作成' do
    context '新規作成できる場合' do
      it 'title・description・youtube_idが存在すれば作成できる' do
        expect(@book).to be_valid
      end
      it 'descriptionが空でも作成できる' do
        @book.description = ''
        expect(@book).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'titleが空では作成できない' do
        @book.title = ''
        expect(@book.valid?).to eq(false)
      end
      it 'youtube_idが空では作成できない' do
        @book.youtube_id = ''
        expect(@book.valid?).to eq(false)
      end
      it 'youtube_idが11文字以外では作成できない' do
        @book.youtube_id = 'AAABBBccc123'
        expect(@book.valid?).to eq(false)
      end
      it 'descriptionが301文字以上では作成できない' do
        @book.description = Faker::Lorem.paragraph_by_chars(number: 301, supplemental: false)
        expect(@book.valid?).to eq(false)
      end
    end
  end
end
