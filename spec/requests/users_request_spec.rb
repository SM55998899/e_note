
require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "PATCH /users/:id" do
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

  describe "before_action: :logged_in_user" do
    let(:user) { FactoryBot.create(:user) }

    it '非ログインユーザが編集しようとしたらログインページに飛ばされるか' do
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

  describe "before_action: :correct_user" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    before { log_in_as(other_user) }
	
    it 'ログインして他のユーザを編集しようとした時、失敗するか' do
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
  end

  describe "POST /users" do
    let(:user) { FactoryBot.attributes_for(:user) }

    it "adds new user with correct signup information and sends an activation email" do
      aggregate_failures do
        expect do
          post users_path, params: { user: user }
        end.to change(User, :count).by(1)
 # ここから追加、及び修正しています。
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        expect(response).to redirect_to root_url
        expect(is_logged_in?).to be_falsy
      end
    end
  end

end