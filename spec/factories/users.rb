FactoryBot.define do
	factory :user do
	  name           { 'username' }
	  email          {Faker::Internet.free_email}
	  password       { 'password' }
      password_confirmation       { 'password' }
	end
  end