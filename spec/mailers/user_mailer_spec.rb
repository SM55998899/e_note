
require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { FactoryBot.create(:user) }
  #account_activationの引数を忘れないこと!!
    let(:mail) { UserMailer.account_activation(user) }

    it "ヘッダーの描画" do
      expect(mail.subject).to eq "Account activation"
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["user@realdomain.com"])
    end

    it "ボディの描画" do
      expect(mail.body.encoded).to match user.name
      expect(mail.body.encoded).to match user.activation_token
   # CGIモジュールのescapeメソッドを使用している。
   # @が%40に変換される
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end
end