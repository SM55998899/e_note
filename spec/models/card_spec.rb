require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card) { FactoryBot.create(:card) }

  it "カードのテストデータが有効かどうか" do
    expect(card).to be_valid
  end

  it "ユーザid無しだと無効かどうか" do
    card.user_id = nil
    expect(card).to be_invalid
  end

  it "カードの表が無記名だと無効" do
    card.front = " "
    expect(card).to be_invalid
  end

  it "カードの裏が無記名だと無効" do
   card.back = " "
   expect(card).to be_invalid
  end

  it "カードの表は20字以内" do
   card.front = "a" * 21
   expect(card).to be_invalid
  end

  it "カードの裏は100字以内" do
    card.back = "a" * 101
    expect(card).to be_invalid
   end


   describe "順序づけ（降順）" do
       let!(:day_before_yesterday) { FactoryBot.create(:card, :day_before_yesterday) }

       let!(:now) { FactoryBot.create(:card, :now) }
       let!(:yesterday) { FactoryBot.create(:card, :yesterday) }
   
       it "succeeds" do
         expect(Card.first).to eq now
       end
     end
end
