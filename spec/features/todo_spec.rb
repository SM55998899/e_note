require 'rails_helper'

RSpec.describe "単体テスト", type: :feature do
	describe "todo機能" do
	 specify '画面の表示' do
		 visit todolist_path
	 end
	end
 end
