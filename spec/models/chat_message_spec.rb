require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  before do
    @chat_message = FactoryBot.build(:chat_message)
  end

  describe 'chatメッセージ投稿' do
    context 'メッセージが投稿できる場合' do
      it 'textが存在していれば保存できる' do
        expect(@chat_message).to be_valid
      end
    end
  end
  context '新規作成できない場合' do
    it 'textが空では作成できない' do
      @chat_message.text = ''
      expect(@chat_message.valid?).to eq(false)
    end
    it 'roomが紐付いていないと投稿できない' do
      @chat_message.room = nil
      expect(@chat_message.valid?).to eq(false)
    end
    it 'userが紐付いていないと投稿できない' do
      @chat_message.user = nil
      expect(@chat_message.valid?).to eq(false)
    end
  end
end
