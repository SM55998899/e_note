# メインのサンプルユーザーを1人作成する
User.create!(name:  "takuya",
	email: "takuya@gmail.com",
	password:              "takuya",
	password_confirmation: "takuya",
	activated: true,
	activated_at: Time.zone.now)

User.create!(name:  "takuma",
	email: "takuma@gmail.com",
	password:              "takuma",
	password_confirmation: "takuma",
	activated: true,
	activated_at: Time.zone.now)

User.create!(name:  "takuto",
	email: "takuto@gmail.com",
	password:              "takuto",
	password_confirmation: "takuto",
	activated: true,
	activated_at: Time.zone.now)

30.times do |n|
	Card.create!(
		user_id: 1,
		front: "takuya(#{n + 1})",
		back: "takuyaの#{ n + 1 }番目のデータです。"
	)

	Card.create!(
		user_id: 2,
		front: "takuma(#{n + 1})",
		back: "takumaの#{ n + 1 }番目のデータです。"
	)

	Micropost.create!(
		user_id: 1,
		content: "takuyaの#{n + 1}番目の日記です。
		          これはテストデータであり、検証のためにあらかじめ作られたものです。
							日記の字数は最大で3000字ですが、今後、調整される可能性があります。
							テストデータが設定された4/4現在、日記には編集機能がありませんが、
							今後追加される可能性があります。"
	)

	Micropost.create!(
		user_id: 2,
		content: "takumaの#{n + 1}番目の日記です。
		          これはテストデータであり、検証のためにあらかじめ作られたものです。
							日記の字数は最大で3000字ですが、今後、調整される可能性があります。
							テストデータが設定された4/4現在、日記には編集機能がありませんが、
							今後追加される可能性があります。"
	)
end
