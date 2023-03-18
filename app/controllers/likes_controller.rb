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
end
