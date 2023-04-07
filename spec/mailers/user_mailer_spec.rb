
require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:user) { FactoryBot.create(:user) }

  describe "account_activation" do
    
  #account_activationの引数を忘れないこと!!
    let(:mail) { UserMailer.account_activation(user) }
    let(:mail_body) { mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join }

    it "ヘッダーの描画" do
      expect(mail.subject).to eq "Account activation"
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["user@realdomain.com"])
    end

    it "ボディの描画" do
      expect(mail_body).to match user.name
      expect(mail_body).to match user.activation_token
   # CGIモジュールのescapeメソッドを使用している。
   # @が%40に変換される
      expect(mail_body).to match CGI.escape(user.email)
    end
  end

   # ここからが今回のテストです。
   describe "パスワードリセットメールについて" do
    # 下の一文を忘れないこと!!
      before { user.reset_token = User.new_token }
  
      let(:mail) { UserMailer.password_reset(user) }
      let(:mail_body) { mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join }
  
      it "ヘッダー描画" do
        expect(mail.subject).to eq("Password reset")
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["user@realdomain.com"])
      end
  
      it "ボディ描画" do
        expect(mail_body).to match user.reset_token
        expect(mail_body).to match CGI.escape(user.email)
      end
    end
end
