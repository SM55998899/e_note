class LikesController < ApplicationController
	def create
    @like = current_user.likes.create(card_id: params[:card_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(card_id: params[:card_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  def index
    @user = current_user
    @cards = @user.cards

    likes = Like.where(user_id: current_user.id).pluck(:card_id)
    @like_list = Card.where(id: likes).paginate(page: params[:page], per_page: 27)
  end
end
