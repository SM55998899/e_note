class CardsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

  def create
	@card = current_user.cards.build(card_params)
    if @card.save
      flash[:success] = "単語を作成しました"
      redirect_to regist_url
    else
	  @feed_items2 = current_user.feed.paginate(page: params[:page])
      render 'static_pages/regist', status: :unprocessable_entity
    end
  end

  def destroy
	@card.destroy
    flash[:success] = "単語を削除しました"
    if request.referrer.nil?
      redirect_to regist_path, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def index
    @cards = Card.all
  end

  private

    def card_params
      params.require(:card).permit(:front,:back)
    end

	def correct_user
		@card = current_user.cards.find_by(id: params[:id])
		redirect_to regist_path, status: :see_other if @card.nil?
	end
end
