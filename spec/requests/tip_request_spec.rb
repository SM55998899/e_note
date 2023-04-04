require 'rails_helper'

RSpec.describe "todo機能（tip）", type: :request do
	let(:user) { FactoryBot.create(:user) }
  
	describe "tip作成について" do

		let!(:list) { FactoryBot.attributes_for(:list) }
  	let(:list_request) { post list_index_path, params: { list: list } }

   context "ログイン時"do
		it "tipが作れる" do
			log_in_as(user)
			list_request
			new_list = List.last
			tip = FactoryBot.attributes_for(:tip, list_id: new_list.id)
			expect { post "/list/1/tip", params: { tip: tip } }.to change(Tip, :count).by(1)
		end
	end

	 context "非ログイン時" do
    it "tipが作れない" do
			expect(get(todolist_path)).to redirect_to(login_path)
    end
	 end
  end

	describe "tip削除について" do
		let!(:list) { FactoryBot.create(:list) }
		let!(:tip) { FactoryBot.create(:tip, list_id: list.id) }
		context "ログイン時" do
     it "tipを削除できる" do
		   log_in_as(user)
       expect { delete list_tip_path(list, tip) }.to change(Tip, :count).by(-1)
		  end
	  end
  end
end
