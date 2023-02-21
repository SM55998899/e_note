
require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  describe "投稿作成の統合テスト" do
    let(:micropost) { FactoryBot.attributes_for(:micropost) }
    let(:post_request) { post microposts_path, params: { micropost: micropost } }

    context "非ログイン時" do
      it "投稿してもカウントされない" do
        expect { post_request }.to change(Micropost, :count).by(0)
      end

      it "投稿ボタンを押すとログインページに飛ばされる" do
        expect(post_request).to redirect_to login_url
      end
    end
  end

  describe "投稿削除の統合テスト" do
    let!(:micropost) { FactoryBot.create(:micropost) }
    let(:delete_request) { delete micropost_path(micropost) }

    context "非ログイン時" do
      it "削除してもカウントされない" do
        expect { delete_request }.to change(Micropost, :count).by(0)
      end

      it "削除ボタンを押すとログイン画面にリダイレクト" do
        expect(delete_request).to redirect_to login_url
      end
    end
  end
end