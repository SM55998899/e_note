require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe "削除依存" do
    before do
      user.save
      user.cards.create!(front:"ruby",back:"プログラミング言語の一種。")
    end

    it "ユーザ削除でカードも削除" do
      expect do
        user.destroy
      end.to change(Card, :count).by(-1)
    end
  end

  it 'ダイジェストが存在しない場合、無効になるか' do
    expect(user.authenticated?(:remember, '')).to be_falsy
  end
end