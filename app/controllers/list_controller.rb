class ListController < ApplicationController
  before_action :set_list, only: %i(edit update destroy)

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
      render action: :edit
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
end
