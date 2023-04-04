class TipController < ApplicationController
  before_action :logged_in_user
  before_action :set_tip, only: %i[show edit update destroy]

	def new
    @tip = Tip.new
    @list = List.find_by(id: params[:list_id])
 end

	def create
    @tip = Tip.new(tip_params)
    if @tip.save
      redirect_to todolist_path
    else
      render action: :new
    end
 end

	def edit
    @lists = List.where(user: current_user)
 end

	def update
    if @tip.update(tip_params)
      redirect_to todolist_path
    else
      render action: :edit
    end
 end

	def destroy
    @tip.destroy
    redirect_to todolist_path
 end

  private

    def tip_params
      params.require(:tip).permit(:title, :memo, :list_id)
    end

		def set_tip
      @tip = Tip.find_by(id: params[:id])
    end

    # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "この機能を使うにはログインが必要です。"
      redirect_to login_url, status: :see_other
    end
  end
end
