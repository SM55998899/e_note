require 'rails_helper'

RSpec.describe "Postモデルのテスト", type: :model do

	before do
		@user = FactoryBot.create(:user)
	end

 describe "バリデーションテスト" do

  it "有効なユーザ情報" do
	expect(@user).to be_valid
  end

  it "名前の存在性" do
	@user.name = ""
    @user.valid?
    expect(@user.errors[:name]).to include("can't be blank")
  end

  it "メールアドレスの存在性" do
    @user.email = ""
    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it "名前が長すぎないかどうか" do
	@user.name = "a"*51
    @user.valid?
    expect(@user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end

  it "メールアドレスが長すぎないかどうか" do
	@user.email = "a" * 244 + "@example.com"
    @user.valid?
    expect(@user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end

  it "有効なメールアドレスが受け入れられる検証" do
	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
		                 first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
    @user.email = valid_address
    expect(@user).to be_valid
   end
  end

  it "無効なメールアドレスが弾かれる検証" do
	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
		foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
    @user.email = invalid_address
    @user.valid?
    expect(@user.errors[:email]).to include("is invalid")
    end
  end

  it "eメールの唯一性の検証" do
	duplicate_user = @user.dup
    @user.save
    duplicate_user.valid?
    expect(duplicate_user.errors[:email]).to include("has already been taken")
  end

  it "パスワードの存在性" do
    @user.password = @user.password_confirmation = " " * 6
    @user.valid?
    expect(@user.errors[:password]).to include("can't be blank")
  end

  it "パスワードの最低文字数" do
    @user.password = @user.password_confirmation = "a" * 5
    @user.valid?
    expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

 end
end