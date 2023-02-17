require "rails_helper"

RSpec.describe "Sessions" do
	describe "log in" do
		it 'ログイン画面の表示に成功すること' do
		  visit login_path
		end
	  end
end