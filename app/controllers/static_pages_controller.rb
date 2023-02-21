class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def diary
    @user = current_user
    @micropost = current_user.microposts.build if logged_in?
  end
end
