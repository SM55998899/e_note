class ListController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  before_action :set_list, only: %i[edit update destroy]

	def new
    @list = List.new
  end

	def create
    @list = List.new(list_params)
    if @list.save
      redirect_to todolist_path
    else
      render action: :new
    end
 end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to todolist_path
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    flash[:success] = "リストを削除しました"
    redirect_to todolist_path
  end

	 private

	def list_params
		params.require(:list).permit(:title).merge(user: current_user)
	end

  def set_list
    @list = List.find_by(id: params[:id])
  end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "この機能を使うにはログインが必要です。"
      redirect_to login_url, status: :see_other
    end
  end

  # 正しいユーザーかどうかを確認
	def correct_user
    @list = List.find_by(id: params[:id])
		redirect_to(root_url, status: :see_other) unless current_user?(@list.user)
	end
end
