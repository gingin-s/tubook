require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      # ユーザー情報
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        expect(@user.valid?).to eq(false)
      end
      it 'nicknameが半角英数字と_以外では登録できない' do
        @user.nickname = 'ニックネーム'
        expect(@user.valid?).to eq(false)
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        expect(@user.valid?).to eq(false)
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        expect(@user.valid?).to eq(false)
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = Faker::Internet.password(min_length: 1, max_length: 5)
        @user.password_confirmation = @user.password
        expect(@user.valid?).to eq(false)
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        expect(@user.valid?).to eq(false)
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = Faker::Internet.password(min_length: 6)
        expect(@user.valid?).to eq(false)
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        user1 = FactoryBot.build(:user, email: @user.email)
        expect(user1.valid?).to eq(false)
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'test.email'
        expect(@user.valid?).to eq(false)
      end
    end
  end
  describe 'ユーザーアイコン編集' do
    let(:image_path) { File.join(Rails.root, 'spec/fixtures/sample.png') }
    let(:image) { Rack::Test::UploadedFile.new(image_path) }
    context '編集できる場合' do
      it 'ユーザーアイコンを登録できる' do
        @user.avatar = image
        expect(@user).to be_valid
      end
    end
  end
end
