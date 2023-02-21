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
end