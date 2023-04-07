require 'rails_helper'

RSpec.describe "単語機能", type: :request do
	let(:user) { FactoryBot.create(:user) }

  	describe "カード作成について"do
  	  let(:card) { FactoryBot.attributes_for(:card) }
  	  let(:post_request) { post cards_path, params: { card: card } }
  
  	  context "ログイン時"do
         it "単語作成すると単語数が増える" do
		  		log_in_as(user)
  	  		expect { post_request }.to change(Card, :count).by(1)
         end
			end

		  context "非ログイン時" do
		  	it "投稿数が変わらない" do
          expect { post_request }.to change(Card, :count).by(0)
        end
		  end
    end

		describe "単語削除時" do
			let!(:card) { FactoryBot.create(:card, user: user) }
			let!(:delete_request) { delete card_path(card) }

			context "ログイン時" do
				it "作った単語を削除すると減る" do
					log_in_as(user)
				  expect {
						delete card_path(card)
					}.to change(Card, :count).by(-1)
				end
			end
	
			context "非ログイン時" do
				it "投稿数は変わらない" do
					expect { delete_request }.to change(Card, :count).by(0)
				end
			end
	
			context "(仕様上あり得ないが)ログイン済みユーザが他ユーザの投稿を削除しようとした時" do
				let(:user) { FactoryBot.create(:user) }
	
				before { log_in_as(user) }
	
				it "投稿数は変わらない" do
					expect { delete_request }.to change(Card, :count).by(0)
				end
			end
		end
end
