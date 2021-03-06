require 'rails_helper'

RSpec.describe Tweet, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:tweet)).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      @tweet = Tweet.new(title: '', body: 'hoge')
      expect(@tweet).to be_invalid
      expect(@tweet.errors[:title]).to include("を入力してください")
    end
    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      @tweet = Tweet.new(title: 'hoge', body: '')
      expect(@tweet).to be_invalid
      expect(@tweet.errors[:body]).to include("を入力してください")
    end
  end
end
