class TodoController < ApplicationController
  before_action :logged_in_user
	before_action :correct_user

	def list
		@lists = List.where(user: current_user).order("created_at ASC")
	end

	private

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url, status: :see_other
		end
	end

	# 正しいユーザーかどうかを確認
	def correct_user
		@user = current_user
		redirect_to(root_url, status: :see_other) unless current_user?(@user)
	end
end
