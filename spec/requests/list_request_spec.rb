require 'rails_helper'

RSpec.describe "todo機能（リスト）", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "リスト作成について" do
		let(:list) { FactoryBot.attributes_for(:list) }
  	let(:list_request) { post list_index_path, params: { list: list } }

		context "ログイン時" do
      it "リストが作れる" do
				log_in_as(user)
        expect { list_request }.to change(List, :count).by(1)
      end
		end

		context "非ログイン時"do
		  it "リストは作れない" do
				expect { list_request }.to change(List, :count).by(0)
		  end
		end
  end

	describe "list削除について" do
		let!(:list) { FactoryBot.create(:list, user: user) }

		context "ログイン時" do
			it "作ったlistを削除できる" do
				log_in_as(user)
				expect {
					delete list_path(list)
				}.to change(List, :count).by(-1)
			end
		end
	end

	describe "ログイン時のlist編集について" do
		let!(:list) { FactoryBot.create(:list, user: user) }

    before { log_in_as(user) }

		it "無効な情報を入力して編集が失敗する" do
      patch list_path(list), params: { list: {
				title: " "}
			}
			expect(response).to have_http_status(422)
		end

		it "有効な情報を入力して編集成功" do
      patch list_path(list), params: { list: {
				title: "午後"}
			}
			expect(response).to redirect_to todolist_path
		end
	end

	describe "非ログイン時のlist編集について" do
		let!(:list) { FactoryBot.create(:list, user: user) }

		it "非ログインユーザが編集ページに行こうとしたらログインページに飛ばされるか" do
      get edit_list_path(list)
			expect(response).to redirect_to login_path
		end

		it '非ログインユーザが編集を実行しようとしたらログインページに飛ばされるか' do
      patch list_path(list), params: { list: {
				title: "午後"}
			}
      expect(response).to redirect_to login_path
    end
	end

	describe "（仕様上あり得ないが）ログイン時の他ユーザの侵害について" do
    let(:other_user) { FactoryBot.create(:user) }
		let!(:list) { FactoryBot.create(:list, user: user) }

    before { log_in_as(other_user) }

		it "ログインして他ユーザが自分のリスト編集ページに移動した時、失敗するか" do
			get edit_list_path(list)
			expect(response).to redirect_to root_path
		end

		it 'ログインして他のユーザが自分のリストを編集しようとした時、失敗するか' do
      patch list_path(list), params: { list: {
				title: "午後"}
			}
      expect(response).to redirect_to root_path
    end

	end
end
