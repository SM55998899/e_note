require 'rails_helper'

RSpec.describe "StaticPagesについて", type: :request do
  let(:user) { FactoryBot.create(:user) }

	describe "非ログイン時、次のページへアクセスすると" do
	 context "ログインページに飛ばされる" do
		it "日記作成ページ" do
     visit diary_path
		 expect(page).to have_current_path(login_path)
		end

		it "単語作成ページ" do
			visit regist_path
			expect(page).to have_current_path(login_path)
		end
	 end
  end

	describe "ログイン時、次のページへアクセスすると" do
		before { log_in_as(user) }

		context "成功する" do
			it "日記作成ページ" do
       get diary_path
			 expect(response).to have_http_status(200)
			end

			it "単語作成ページ" do
       get regist_path
			 expect(response).to have_http_status(200)
			end
		end
	end
end
