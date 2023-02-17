require 'rails_helper'

RSpec.describe "単体テスト", type: :feature do
 describe "sign up" do
	specify '画面の表示' do
		visit signup_path
		expect(page.title).to eq('Sign up | e-note')
	end
 end
end