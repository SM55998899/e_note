class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user,   only: %i(edit update show)

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "アカウント有効化メールをお使いのメールアドレスに送りました。確認して下さい。"
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def index
    @user = current_user
    @cards = @user.cards.paginate(page: params[:page], per_page: 20)
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def search
    @user = current_user
    if params[:keyword].present?
      @cards = @user.cards.where('front LIKE ? OR back LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @microposts = @user.microposts.where('content LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @cards = @user.cards
      @microposts = @user.microposts
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # 正しいユーザーかどうかを確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    # 管理者かどうかを確認
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
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
