require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room= FactoryBot.build(:room)
  end
  describe 'room新規作成' do
    context '新規作成できる場合' do
      it 'nameが存在すれば作成できる' do
        expect(@room).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'nameが空では作成できない' do
        @room.name = ''
        expect(@room.valid?).to eq(false)
      end
    end
  end
  describe 'roomアイコン編集' do
    let(:image_path) { File.join(Rails.root, 'spec/fixtures/sample.png') }
    let(:image) { Rack::Test::UploadedFile.new(image_path) }
    context '編集できる場合' do
      it 'roomアイコンを登録できる' do
        @room.avatar = image
        expect(@room).to be_valid
      end
    end
  end
end
