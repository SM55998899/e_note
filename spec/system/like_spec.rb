require 'rails_helper'
 #request_specでは複雑に思えたのでsystem_specで検証しました。
RSpec.describe "マーク(いいね)機能について", type: :system do
	let(:user) { FactoryBot.create(:user) }
	let(:card) { FactoryBot.create(:card) }

	before do
		login_as(user)
	end

	it "ユーザーが単語を作り、いいねをして解除できる" do
		visit regist_path

		fill_in "card_front", with: "apple"
    fill_in "card_back", with: "りんご"

    click_button "単語を作成"

    expect(page).to have_content("単語を作成しました")

		# いいねをするボタンを押す
		find('#liking-btn').click
    expect(page).to have_selector '#nolike-btn'
    expect(Like.count).to eq(1)

		# いいねを解除する
		find('#nolike-btn').click
		expect(page).to have_selector '#liking-btn'
		expect(Like.count).to eq(0)
	end
end
