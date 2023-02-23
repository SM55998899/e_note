require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  describe "投稿作成時" do
    let(:micropost) { FactoryBot.attributes_for(:micropost) }
    let(:post_request) { post microposts_path, params: { micropost: micropost } }

    context "非ログイン時" do
      it "投稿数が変わらない" do
        expect { post_request }.to change(Micropost, :count).by(0)
      end

      it "ログイン画面に移行" do
        expect(post_request).to redirect_to login_url
      end
    end
  end

  describe "投稿削除時" do
    let!(:micropost) { FactoryBot.create(:micropost) }
    let(:delete_request) { delete micropost_path(micropost) }

    context "非ログイン時" do
      it "投稿数は変わらない" do
        expect { delete_request }.to change(Micropost, :count).by(0)
      end

      it "ログイン画面へ移行" do
        expect(delete_request).to redirect_to login_url
      end
    end

    context "ログイン済みユーザが他ユーザの投稿を削除しようとした時" do
      let(:user) { FactoryBot.create(:user) }

      before { log_in_as(user) }

      it "投稿数は変わらない" do
        expect { delete_request }.to change(Micropost, :count).by(0)
      end
      it "ログイン画面へ移行" do
        expect(delete_request).to redirect_to root_url
      end
    end
  end
end