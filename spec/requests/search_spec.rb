require 'rails_helper'

RSpec.describe "検索機能について", type: :request do
  describe "ログイン時、yesterdayと検索したら、" do
		before do
      @user = FactoryBot.create(:user)
      @card_yesterday = FactoryBot.create(:card, :yesterday, user: @user)
      @card_day_before_yesterday = FactoryBot.create(:card, :day_before_yesterday, user: @user)
      @card_now = FactoryBot.create(:card, :now, user: @user)
      log_in_as(@user)
      get search_users_path, params: { keyword: 'yesterday' }
    end

		it 'リクエストは成功' do
      expect(response).to be_successful
    end

    it 'ステータス200が返される' do
      expect(response).to have_http_status '200'
    end

		it '検索結果が正しく反映される' do
      expect(response.body).to include @card_yesterday.front
      expect(response.body).to include @card_yesterday.back
      expect(response.body).to include @card_day_before_yesterday.front
			expect(response.body).to include @card_day_before_yesterday.back
      expect(response.body).not_to include @card_now.front
			expect(response.body).not_to include @card_now.back
    end
  end
end
