require 'rails_helper'

RSpec.describe "単体テスト", type: :feature do
	describe "一覧、検索機能" do
	 specify '画面の表示' do
		 visit users_path
	 end
	end
 end
