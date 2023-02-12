require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "間違った情報でログインする統合テスト" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  #あとで「Eメールは合っているがパスワードが違う場合の統合テスト」と
  #「正しくログインとログアウトができる統合テスト」を追加する
end
