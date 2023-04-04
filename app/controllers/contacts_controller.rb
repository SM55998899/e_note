class ContactsController < ApplicationController
  before_action :logged_in_user, only: %i(new create)

	def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, current_user).deliver
      redirect_to root_path, notice: 'お問い合わせ内容を送信しました'
    else
      render :new
    end
  end

	private

    def contact_params
      params.require(:contact).permit(:name, :content)
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
