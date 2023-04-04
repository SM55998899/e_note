require 'rails_helper'

RSpec.describe "日記機能", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "日記作成時" do
    let(:micropost) { FactoryBot.attributes_for(:micropost) }
    let(:post_request) { post microposts_path, params: { micropost: micropost } }

    context "ログイン時" do
      it "投稿できる" do
        log_in_as(user)
        expect { post_request }.to change(Micropost, :count).by(1)
      end
    end

    context "非ログイン時" do
      it "投稿数が変わらない" do
        expect { post_request }.to change(Micropost, :count).by(0)
      end

      it "ログイン画面に移行" do
        expect(post_request).to redirect_to login_url
      end
    end
  end

  describe "日記削除時" do
    let!(:micropost) { FactoryBot.create(:micropost, user: user) }
    let(:delete_request) { delete micropost_path(micropost) }

    context "ログイン時" do
      it "投稿を削除できる" do
        log_in_as(user)
        expect { delete_request }.to change(Micropost, :count).by(-1)
      end
    end

    context "非ログイン時" do
      it "削除しようとしても投稿数は変わらない" do
        expect { delete_request }.to change(Micropost, :count).by(0)
      end

      it "ログイン画面へ移行" do
        expect(delete_request).to redirect_to login_url
      end
    end
  end

  describe "(仕様上あり得ないが)ログイン時の他ユーザの侵害について" do
    let(:other_user) { FactoryBot.create(:user) }
    let!(:micropost) { FactoryBot.create(:micropost, user: user) }
    before { log_in_as(other_user) }

    context "ログイン済みユーザが他ユーザの投稿を削除しようとした時" do

      it "投稿数は変わらない" do
        expect { delete micropost_path(micropost) }.to change(Micropost, :count).by(0)
      end
      it "ログイン画面へ移行" do
        expect( delete micropost_path(micropost) ).to redirect_to(root_url)
      end
    end

    context "ログイン済みユーザが他ユーザの日記を閲覧しようとした時" do
      it "ログイン画面へ移行" do
        expect( get micropost_path(micropost) ).to redirect_to root_url
      end
    end
  end
end
