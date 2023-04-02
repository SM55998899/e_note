class ContactMailer < ApplicationMailer
	def contact_mail(contact, user)
    @contact = contact
    mail to: user.email, subject: "お問い合わせについて【自動送信】"
  end

  def send_mail(contact)
    @contact = contact
    mail(
      from: 'system@example.com',
      to:   'shotapekka@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
end
