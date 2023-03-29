class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
    end
  end

  def help
  end

  def diary
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def regist
    if logged_in?
      @card  = current_user.cards.build
      @feed_items2 = current_user.feed2.paginate(page: params[:page], per_page: 6)
    end
  end
end
