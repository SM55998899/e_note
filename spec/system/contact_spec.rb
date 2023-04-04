require "rails_helper"

RSpec.describe "問い合わせ", type: :system do

	let(:user) { FactoryBot.create(:user) }
	let(:contact) { FactoryBot.create(:contact, user_id: user.id) }

#前もってログインしておく
	before {login_as(user)}

	  context "統合テスト" do
      it "問い合わせ可能かどうか" do
        # ログイン後に問い合わせページにアクセスする
	  	  visit new_contact_path
	  	  expect(page).to have_current_path(new_contact_path)

        fill_in 'お名前', with: contact.name
	  	  fill_in 'お問合せ内容を入力してください', with: contact.content
	  	  click_button '送信'
				
				expect(page).to have_current_path(root_path)
	    end
   end
end
