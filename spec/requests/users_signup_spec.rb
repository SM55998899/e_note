require "rails_helper"

RSpec.describe "Users signup", type: :request do

  example "正しくアカウント作成してホーム画面に戻れるか" do
    get signup_path
    expect {
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    }.to change(User, :count).by(1)
    redirect_to @user
    follow_redirect!
  end

  example "正しくない情報でアカウント作成した場合、エラーになるか" do
    get signup_path
    expect {
      post users_path, params: { user: { name:  "",
        email: "user@invalid",
        password:              "foo",
        password_confirmation: "bar" } }
      }.to change(User, :count).by(0)
    expect(response.status).to eq(422)
    expect(response).to render_template('users/new')
    end
end
