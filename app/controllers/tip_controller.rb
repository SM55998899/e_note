class TipController < ApplicationController
  before_action :set_tip, only: %i(show edit update)

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

	def show
  end

	def edit
  end

	def update
    if @tip.update(tip_params)
      redirect_to todolist_path
    else
      render action: :edit
    end
  end
  private
    def tip_params
      params.require(:tip).permit(:title, :memo, :list_id)
    end

		def set_tip
      @tip = Tip.find_by(id: params[:id])
    end
end
