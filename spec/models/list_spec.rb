require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) { FactoryBot.create(:list) }

  it "リストのテストデータが有効かどうか" do
    expect(list).to be_valid
  end

  it "ユーザid無しだと無効かどうか" do
    list.user_id = nil
    expect(list).to be_invalid
  end

  it "リストのタイトルが無記名だと無効" do
    list.title = " "
    expect(list).to be_invalid
  end

	it "リストのタイトルは55字以内" do
		list.title = "a" * 56
		expect(list).to be_invalid
	 end

	 describe "順序づけ" do
		   let!(:now) { FactoryBot.create(:list, :now2) }
			 let!(:day_before_yesterday) { FactoryBot.create(:list, :day_before_yesterday2) }
       let!(:yesterday) { FactoryBot.create(:list, :yesterday2) }

			 it "古いリストが右に並ぶかどうか" do
				expect(List.first).to eq day_before_yesterday
			end
		end
end
