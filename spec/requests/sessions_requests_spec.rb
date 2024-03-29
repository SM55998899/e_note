require 'rails_helper'

RSpec.describe "Sessions", type: :request do
	let(:user) { FactoryBot.create(:user) }

describe "ログアウト統合テスト" do
    it 'ホーム画面へリダイレクトされる' do
      post login_path, params: { session: {
        email: user.email,
        password: user.password,
      } }
      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsy
      end
    end

    it '二つのタブでログアウトする場合' do
      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsy
      end
    end
end

describe 'ログイン状態保持' do
    it "ユーザがチェックを入れた時にクッキーが記憶されているか" do
      log_in_as(user)
      expect(cookies[:remember_token]).not_to eq nil
    end
    it "未チェック時、クッキーは未記憶か" do
      log_in_as(user, remember_me: '0')
      expect(cookies[:remember_token]).to eq nil
    end
  end

  describe "フレンドリーフォワーディングについて" do
    let(:user) { FactoryBot.create(:user) }
    it '成功する' do
      get edit_user_path(user)
      log_in_as(user)
      expect(response).to redirect_to edit_user_url(user)
    end
  end
end
