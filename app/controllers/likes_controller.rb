class LikesController < ApplicationController
  before_action :correct_user, only: %i[create destroy index]

	def create
    @like = @user.likes.create(card_id: params[:card_id])
    redirect_to regist_path
  end

  def destroy
    @like = Like.find_by(card_id: params[:card_id], user_id: current_user.id)
    @like.destroy
    redirect_to regist_path
  end

  def index
    @cards = @user.cards

    likes = Like.where(user_id: current_user.id).pluck(:card_id)
    @like_list = Card.where(id: likes).paginate(page: params[:page], per_page: 27)
  end

  private

  # 正しいユーザーかどうかを確認
  def correct_user
    @user = current_user
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end
end
