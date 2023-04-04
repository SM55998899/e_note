FactoryBot.define do
  factory :tip do
    id { 1 }
    title { "青チャート30問" }
  end

  trait :yesterday3 do
    title { "昨日" }
    created_at { 1.day.ago }
  end

  trait :day_before_yesterday3 do
    title { "一昨日" }
    created_at { 2.days.ago }
  end

  trait :now3 do
    title { "今" }
    created_at { Time.zone.now }
  end
end
