class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def diary
    @micropost = current_user.microposts.build if logged_in?
  end
end
