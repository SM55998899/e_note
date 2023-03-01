require "rails_helper"

RSpec.describe "User login", type: :request do

	before do
		@user = FactoryBot.create(:user)
	end

context "ログインテスト" do
	it "正しくログインする一連の流れを確かめる統合テスト"do
	visit root_path
	visit login_path
    fill_in 'session[email]', with: @user.email
	fill_in 'session[password]', with: @user.password
	click_button 'Log in'
	expect(current_path).to eq '/users/1'
	end
 end
end
