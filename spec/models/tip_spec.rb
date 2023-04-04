require 'rails_helper'

RSpec.describe Tip, type: :model do
  let(:tip) { FactoryBot.create(:tip, list: FactoryBot.create(:list)) }

  it "リストのテストデータが有効かどうか" do
    expect(tip).to be_valid
  end

  it "リストに関連づいてないと無効かどうか" do
		tip.list = nil
    expect(tip).to be_invalid
  end

  it "リストのタイトルが無記名だと無効" do
    tip.title = " "
    expect(tip).to be_invalid
  end

	it "リストのタイトルは55字以内" do
		tip.title = "a" * 56
		expect(tip).to be_invalid
	 end

	 it "リストのメモは100字以内" do
		tip.memo = "a" * 101
		expect(tip).to be_invalid
	 end

end
