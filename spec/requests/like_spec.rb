require 'rails_helper'

RSpec.describe "マーク（いいね）機能について", type: :request do
	let(:user) { FactoryBot.create(:user) }
	let!(:card) { FactoryBot.create(:card) }
	let!(:post_request) { post cards_path, params: { card: card } }

 describe "マークを付ける事について" do

  context "ログイン時" do
  	before do
  		log_in_as(user)
  	end

		it "マークするとマーク数が増える" do
			get regist_path
			post_request
			expect { post card_likes_path(card.id), params: { card_id: card.id }}.to change(Like, :count).by(1)
			expect(response).to redirect_to(regist_path)
		end
  end
 end
 end
end
