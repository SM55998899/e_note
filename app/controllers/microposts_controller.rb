class MicropostsController < ApplicationController
	before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user,   only: %i(destroy show)

	def create
	  @micropost = current_user.microposts.build(micropost_params)
	  if @micropost.save
		flash[:success] = "日記を作成しました！"
		redirect_to diary_path
	  else
		@feed_items = current_user.feed.paginate(page: params[:page])
		redirect_to request.referrer, status: :see_other
	  end
	end
  
	def destroy
		@micropost.destroy
		flash[:success] = "日記を削除しました"
		if request.referrer.nil?
		  redirect_to diary_path, status: :see_other
		else
		  redirect_to request.referrer, status: :see_other
		end
	end

	def show
		@micropost = Micropost.find_by(id: params[:id])
	end
  
	private
  
	  def micropost_params
		params.require(:micropost).permit(:content)
	  end

	  def correct_user
		@micropost = current_user.microposts.find_by(id: params[:id])
		redirect_to root_url, status: :see_other if @micropost.nil?
	  end
  end
