
require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "ログイン時のユーザー編集" do
    let(:user) { FactoryBot.create(:user) }

    before { log_in_as(user) }

	  it '無効な情報を入力して編集が失敗する' do
	  	patch user_path(user), params: { user: {
	  	  name: " ",
	  	  email: "foo@invalid",
	  	  password: "foo",
	  	  password_confirmation: "bar",
	  	} }
	  	expect(response).to have_http_status(422)
	   end

    it '有効な情報を入力して編集が成功する' do
      patch user_path(user), params: { user: {
        name: "Foo Bar",
        email: "foo@bar.com",
        password: "",
        password_confirmation: "",
      } }
      expect(response).to redirect_to user_path(user)
    end
  end

  describe "非ログイン時のユーザー編集" do
    let(:user) { FactoryBot.create(:user) }

    it '非ログインユーザが編集ページに行こうとしたらログインページに飛ばされるか' do
      get edit_user_path(user)
      expect(response).to redirect_to login_path
    end

    it '非ログインユーザがアップデートしようとしてもログインページに飛ばされるか' do
      patch user_path(user), params: { user: {
        name: user.name,
        email: user.email,
      } }
      expect(response).to redirect_to login_path
    end
  end

  describe "ログイン時の他ユーザーページへの侵入" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    before { log_in_as(other_user) }
	
    it 'ログインして他のユーザを編集ページに行こうとした時、失敗するか' do
      get edit_user_path(user)
      expect(response).to redirect_to root_path
    end

    it 'ログインして他のユーザ編集を実行しようとした時、失敗するか' do
      patch user_path(user), params: { user: {
        name: user.name,
        eemail: user.email,
      } }
      expect(response).to redirect_to root_path
    end

    it "ログインして他のユーザプロフィールを覗こうとした時、失敗するか" do
      get user_path(user)
      expect(response).to redirect_to root_path
    end
  end

  describe "有効化メール" do
    let(:user) { FactoryBot.attributes_for(:user) }

    it "正しくアカウント作成して有効化のメールが送られるか" do
      aggregate_failures do
        expect do
          post users_path, params: { user: user }
        end.to change(User, :count).by(1)
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        expect(response).to redirect_to root_url
        expect(is_logged_in?).to be_falsy
      end
    end
  end

end
