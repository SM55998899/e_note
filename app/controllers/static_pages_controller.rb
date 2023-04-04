class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: %i(diary regist)
  before_action :correct_user, only: %i(diary regist)

  def home
    if logged_in?
      @user = current_user
    end
  end

  def help
  end

  def diary
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
  end

  def regist
      @card  = current_user.cards.build
      @feed_items2 = current_user.feed2.paginate(page: params[:page], per_page: 6)
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "この機能を使うにはログインが必要です。"
      redirect_to login_url, status: :see_other
    end
  end

  def correct_user
    @user = current_user
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end
end
