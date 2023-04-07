require 'rails_helper'

RSpec.describe "パスワード再設定の統合テスト", type: :request do
  let(:user) { FactoryBot.create(:user) }
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe "newアクション" do
    it "正しい入力フォームがある" do
      get new_password_reset_path
      expect(response.body).to include 'name="password_reset[email]"'
    end
  end

  describe "createアクション" do
    context "有効なメールアドレスの場合" do
      it "reset digestを作る" do
        post password_resets_path, params: { password_reset: { email: user.email } }
        user.reload
        expect(user.reset_digest).to_not be_nil
      end

      it "送信するメールを一つ増やせること" do
        expect{
          post password_resets_path, params: { password_reset: { email: user.email } }
        }.to change(ActionMailer::Base::deliveries, :count).by 1
      end

      it "フラッシュメッセージが表示されること" do
        post password_resets_path, params: { password_reset: { email: user.email } }
        expect(flash).to_not be_empty
      end

      it "ホーム画面にリダイレクトされること" do
        post password_resets_path, params: { password_reset: { email: user.email } }
        expect(response).to redirect_to root_url
      end
    end

    context "無効なメアドの場合" do
      it "フラッシュメッセージが表示されること" do
        post password_resets_path, params: { password_reset: { email: "" } }
        expect(flash).to_not be_empty
      end
      it "/password_resets/newが表示される事" do
        post password_resets_path, params: { password_reset: { email: "" } }
        expect(response.body).to include full_title("Forgot password")
      end
      it "reset digestが作られないこと" do
        post password_resets_path, params: { password_reset: { email: "" } }
        user.reload
        expect(user.reset_digest).to be_nil
      end
    end
  end

  describe "editアクションにおいて email, reset_tokenが" do
    before do
      post password_resets_path, params: { password_reset: { email: user.email } }
      @user = controller.instance_variable_get(:@user)
    end

    context "有効な時" do
      it "アクセスが成功すること" do
        get edit_password_reset_path(@user.reset_token, email: user.email)
        expect(response.body).to include full_title("Reset password")
      end

      it "email保持のフォームを持っている" do
        # メールアドレスを保持するためのフォーム
        form = "<input type=\"hidden\" name=\"email\" id=\"email\" value=\"#{@user.email}\" />"

        #get edit_password_reset_path(@user.reset_token, email: user.email)
        #expect(response.body).to include form
      end
    end

    context "無効の場合" do
      it "無効なeメールだとホーム画面にリダイレクトされる" do
        get edit_password_reset_path(@user.reset_token, email: "")
        expect(response).to redirect_to root_url
      end

      it "無効なトークンだとホーム画面にリダイレクトされる" do
        get edit_password_reset_path("Invalid token", email: user.email)
        expect(response).to redirect_to root_url
      end
    end

    context "有効化されてないユーザーの場合" do
      it "ホーム画面に飛ばされる" do
        @user.toggle!(:activated)
        get edit_password_reset_path(@user.reset_token, email: user.email)
        expect(response).to redirect_to root_url
      end
    end

	context "パスワード再設定用トークンが期限切れになった場合" do
		before do
		  @user.update_attribute(:reset_sent_at, 3.hours.ago)
		end
		it "パスワードリセット画面に飛ばされる事" do
		  get edit_password_reset_path(@user.reset_token, email: @user.email)
		  expect(response).to redirect_to new_password_reset_path
		end
	  end
  end

  describe "#updateにおいて" do
    before do
      post password_resets_path, params: { password_reset: { email: user.email } }
      @user = controller.instance_variable_get(:@user)
    end

    context "パスワードと確認が有効な場合" do
      it "ログインされること" do
        patch password_reset_path(@user.reset_token), params: {
          email: @user.email,
          user: { password: "newPassword", password_confirmation: "newPassword" }
        }
        expect(is_logged_in?).to be_truthy
      end

      it "フラッシュメッセージが表示される事" do
        patch password_reset_path(@user.reset_token), params: {
          email: @user.email,
          user: { password: "newPassword", password_confirmation: "newPassword" }
        }
        expect(flash).to_not be_empty
      end

      it "ユーザプロフィール画面にリダイレクトされる事" do
        patch password_reset_path(@user.reset_token), params: {
          email: @user.email,
          user: { password: "newPassword", password_confirmation: "newPassword" }
        }
        expect(response).to redirect_to user
      end

      it "ユーザパスワードが変更されること" do
        patch password_reset_path(@user.reset_token), params: {
          email: @user.email,
          user: { password: "newPassword", password_confirmation: "newPassword" }
        }
        old_password = @user.password_digest
        @user.reload
        expect(@user.authenticated?(:password, old_password)).to_not be_truthy
      end
    end

    context "パスワードと確認が無効な場合" do
      it "それらが無効だというエラー文が表示される事" do
        patch password_reset_path(@user.reset_token), params: {
          email: @user.email,
          user: { password: "newPassword", password_confirmation: "wrongPassword" }
        }
        expect(response.body).to include '<div id="error_explanation">'
      end

      it "それらが空な場合、エラーが表示される事" do
        patch password_reset_path(@user.reset_token), params: {
          email: @user.email,
          user: { password: "", password_confirmation: "" }
        }
        expect(response.body).to include '<div id="error_explanation">'
      end
    end
  

  context "パスワード再設定用トークンが期限切れになった場合" do
	before do
	  @user.update_attribute(:reset_sent_at, 3.hours.ago)
	end

	it "期限切れの正しいエラー文が表示される事" do
	  patch password_reset_path(@user.reset_token), params: {
		email: @user.email,
		user: { password: "newPassword", password_confirmation: "newPassword" }
	  }
	  follow_redirect!
	  expect(response.body).to include "パスワードリセットは期限切れです。やり直して下さい。"
	end

	it "再設定ページに飛ばされる事" do
	  patch password_reset_path(@user.reset_token), params: {
		email: @user.email,
		user: { password: "newPassword", password_confirmation: "newPassword" }
	  }
	  expect(response).to redirect_to new_password_reset_path
	end
  end
end
end
