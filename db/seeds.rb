# メインのサンプルユーザーを1人作成する
User.create!(name:  "takuya",
	email: "takuya@gmail.com",
	password:              "takuya",
	password_confirmation: "takuya",
	activated: true,
	activated_at: Time.zone.now)
