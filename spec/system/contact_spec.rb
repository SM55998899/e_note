require "rails_helper"

RSpec.describe "問い合わせ", type: :system do

	let!(:user) { FactoryBot.create(:user) }
	let!(:contact) { FactoryBot.create(:contact) }

#前もってログインしておく
	before do
		visit root_path
	  click_link "ログイン"
    fill_in 'session[email]', with: user.email 
    fill_in 'session[password]', with: user.password
    click_button 'ログインする'
	end

	context "統合テスト" do
    it "問い合わせ可能かどうか" do
    # ログイン後に問い合わせページにアクセスする
		visit root_path
		click_link "お問い合わせ"
		expect(page).to have_current_path(new_contact_path(user_id: user.id))
    fill_in 'お名前', with: contact.name
		fill_in 'お問合せ内容を入力してください', with: contact.content
		click_button '送信'
	end
end
end
