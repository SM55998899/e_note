
require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }

  describe 'current_user' do
    before do
      remember(user)
    end

    it '現在のユーザはセッションがない場合、真になる' do
      expect(current_user).to eq user
      expect(is_logged_in?).to be_truthy
    end
    it '現在のユーザが「記憶ダイジェストと記憶トークンが正しく噛み合わない」場合、nilになる' do
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to eq nil
    end
  end
end