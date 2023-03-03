FactoryBot.define do
	factory :user do
	  name           { 'username' }
	  email          {Faker::Internet.free_email}
	  password       { 'password' }
      password_confirmation       { 'password' }
	  activated { true }
      activated_at { Time.zone.now }

	  trait :admin do
		admin { true }
	  end
  
  # 新しく追加します。
	  trait :no_activated do
		activated { false }
		activated_at { nil }
	  end

	end
  end