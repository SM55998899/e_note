module TestHelper
	def is_logged_in?
	  !session[:user_id].nil?
	end
end

module SystemHelper
	def login_as(user)
	  visit login_path
	  fill_in 'session[email]',    with: user.email
	  fill_in 'session[password]', with: user.password
	  click_button 'ログインする'
	end

	def registCard(front, back)
    visit regist_path

		fill_in 'card_front', with: front
		fill_in 'card_back', with: front

		click_button "単語を作成"
	end
end
  RSpec.configure do |config|
	config.include TestHelper
	config.include SystemHelper  #<=  追加
  end
