require "rails_helper"

RSpec.describe "User loginの統合テスト", type: :system do

	# use let/let! instead to setup test dependencies.
	let!(:user) { FactoryBot.create(:user) }

context "ログインテスト" do
	it "正しくログインすること"do
	visit root_path
	click_link "ログイン" # or whatever link there is in the UI
    fill_in 'session[email]', with: user.email # Use the labels like real person would
    fill_in 'session[password]', with: user.password
    click_button 'ログインする'
	expect(current_path).to eq root_path
	end
 end
end
