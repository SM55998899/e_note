module UsersHelper
    # ページごとの完全なタイトルを返す
  def full_title(page_title = '')
    base_title = "e-note"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

   # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user, size: 80)
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
