require 'rails_helper'

RSpec.describe Micropost, type: :model do
# associationで関連付けしているので、Userオブジェクトを自分で作らなくていい!!
  let(:micropost) { FactoryBot.create(:micropost) }

  it "投稿テストデータが有効か" do
    expect(micropost).to be_valid
  end

  it "ユーザidがないと無効になるか" do
    micropost.user_id = nil
    expect(micropost).to be_invalid
  end

  it "コンテンツがないと無効になるか" do
    micropost.content = " "
    expect(micropost).to be_invalid
  end

  it "投稿が140字以内かどうか" do
    micropost.content = "a" * 3001
    expect(micropost).to be_invalid
  end

  describe "Sort by latest" do
    # 評価される前にdbに保存されていないといけないので、「let!」を使用します。
       let!(:day_before_yesterday) { FactoryBot.create(:micropost, :day_before_yesterday) }
    # FactoryBot.create(:micropost, :now) を一番上に持ってくるとテストの意味がなくなるので注意です。
       let!(:now) { FactoryBot.create(:micropost, :now) }
       let!(:yesterday) { FactoryBot.create(:micropost, :yesterday) }
   
       it "succeeds" do
         expect(Micropost.first).to eq now
       end
     end
end
