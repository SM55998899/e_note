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
end
  RSpec.configure do |config|
	config.include TestHelper
	config.include SystemHelper  #<=  追加
  end
