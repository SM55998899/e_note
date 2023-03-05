module IntegrationHelpers
	def is_logged_in?
	  !session[:user_id].nil?
	end

	# テストユーザーとしてログインする
	def log_in_as(user, password: 'password', remember_me: '1')
		post login_path, params: { session: { email: user.email,
											  password: password,
											  remember_me: remember_me } }
	end

	def full_title(page_title = '')
		base_title = "e-note"
		if page_title.empty?
		  base_title
		else
		  "#{page_title} | #{base_title}"
		end
	end
  end