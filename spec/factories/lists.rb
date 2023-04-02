FactoryBot.define do
  factory :list do
    title { "午前中" }
    association :user
  end

  trait :yesterday2 do
    title { "昨日" }
    created_at { 1.day.ago }
  end

  trait :day_before_yesterday2 do
    title { "一昨日" }
    created_at { 2.days.ago }
  end

  trait :now2 do
    title { "今" }
    created_at { Time.zone.now }
  end
end
