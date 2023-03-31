require "rails_helper"

RSpec.describe "問い合わせ統合テスト", type: :system do

	let!(:user) { FactoryBot.create(:user) }

#前もってログインしておく
	before do
		visit root_path
	  click_link "ログイン"
    fill_in 'session[email]', with: user.email 
    fill_in 'session[password]', with: user.password
    click_button 'Log in'
	end

	context "問い合わせ可能かどうか" do

	end
end
