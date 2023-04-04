class ApplicationController < ActionController::Base
	include SessionsHelper
  
	private
  
	  # ユーザーのログインを確認する
	  def logged_in_user
		unless logged_in?
		  store_location
		  flash[:danger] = "この機能を使うにはログインが必要です。"
		  redirect_to login_url, status: :see_other
		end
	  end
  end
