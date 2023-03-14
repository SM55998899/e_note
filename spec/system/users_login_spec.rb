require "rails_helper"

RSpec.describe "User loginの統合テスト", type: :system do

	# use let/let! instead to setup test dependencies.
	let!(:user) { FactoryBot.create(:user) }

context "ログインテスト" do
	it "正しくログインすること"do
	visit root_path
	click_link "ログイン" # or whatever link there is in the UI
    fill_in 'Email', with: user.email # Use the labels like real person would
    fill_in 'Password', with: user.password
    click_button 'Log in'
	expect(current_path).to eq user_path(user)
	end
 end
end
