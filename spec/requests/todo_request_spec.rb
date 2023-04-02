require 'rails_helper'

RSpec.describe "todo機能", type: :request do
  describe "リスト,tip作成について" do
		let(:user) { FactoryBot.create(:user) }
		let(:list) { FactoryBot.attributes_for(:list) }
  	let(:list_request) { post list_index_path, params: { list: list } }

		context "ログイン時" do
      it "リストが作れる" do
				log_in_as(user)
        expect { list_request }.to change(List, :count).by(1)
      end

			it "tipが作れる" do
				log_in_as(user)
				list_request
				new_list = List.last
				tip = FactoryBot.attributes_for(:tip, list_id: new_list.id)
				expect { post "/list/1/tip", params: { tip: tip } }.to change(Tip, :count).by(1)
			end
		end

		context "非ログイン時"do
		  it "リストは作れない" do
				expect { list_request }.to change(List, :count).by(0)
		  end
		end
  end

	describe "list, tip削除について" do
		let(:user) { FactoryBot.create(:user) }
		let(:list) { FactoryBot.create(:list, user: user) }

		#context "ログイン時" do
		#	it "作ったlistを削除できる" do
		#		log_in_as(user)
		#		  expect {
		#				delete list_path(list[:id])
		#			}.to change(List, :count).by(-1)
		#	end
		#end
	end
end
