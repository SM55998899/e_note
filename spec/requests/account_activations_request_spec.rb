
require 'rails_helper'

RSpec.describe "アカウント有効化について", type: :request do
  let(:user) { FactoryBot.create(:user, :no_activated) }

  context '正しいトークンと間違ったemailの場合' do
    before do
      get edit_account_activation_path(user.activation_token, email: 'wrong')
    end

    it "ログインに失敗する" do
      expect(is_logged_in?).to be_falsy
      expect(response).to redirect_to root_url
    end
  end

  context '間違ったトークンと正しいemailの場合' do
    before do
      get edit_account_activation_path('invalid token', email: user.email)
    end

    it "ログインに失敗する" do
      expect(is_logged_in?).to be_falsy
      expect(response).to redirect_to root_url
    end
  end

  context 'トークン、emailが両方正しい場合' do
    before do
      get edit_account_activation_path(user.activation_token, email: user.email)
    end

    it "ログインに成功する" do
      expect(is_logged_in?).to be_truthy
      expect(response).to redirect_to user
    end
  end
end
