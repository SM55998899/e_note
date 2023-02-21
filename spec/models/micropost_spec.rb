require 'rails_helper'

RSpec.describe Micropost, type: :model do
# associationで関連付けしているので、Userオブジェクトを自分で作らなくていい!!
  let(:micropost) { FactoryBot.create(:micropost) }

  it "テストデータの有効性" do
    expect(micropost).to be_valid
  end

  it "ユーザidの存在性" do
    micropost.user_id = nil
    expect(micropost).to be_invalid
  end

  it "中身の存在性" do
    micropost.content = " "
    expect(micropost).to be_invalid
  end

  it "中身は141字以内" do
    micropost.content = "a" * 141
    expect(micropost).to be_invalid
  end

  describe "投稿の順序づけ" do
    # 評価される前にdbに保存されていないといけないので、「let!」を使用します。
       let!(:day_before_yesterday) { FactoryBot.create(:micropost, :day_before_yesterday) }
    # FactoryBot.create(:micropost, :now) を一番上に持ってくるとテストの意味がなくなるので注意です。
       let!(:now) { FactoryBot.create(:micropost, :now) }
       let!(:yesterday) { FactoryBot.create(:micropost, :yesterday) }
   
       it "最新のものを先頭に持ってくる" do
         expect(Micropost.first).to eq now
       end
  end
end