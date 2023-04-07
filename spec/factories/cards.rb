FactoryBot.define do
  factory :card do
    front { "アジャイル開発" }
    back { "web自社開発等の現場において、トライアンドエラーを短いサイクルで行う開発形態" }
    association :user
  end

  trait :yesterday do
    front { "yesterday" }
    back {"yesterday"}
    created_at { 1.day.ago }
    association :user
  end

  trait :day_before_yesterday do
    front { "day_before_yesterday" }
    back {"day_before_yesterday"}
    created_at { 2.days.ago }
    association :user
  end

  trait :now do
    front { "now!" }
    back {"now!"}
    created_at { Time.zone.now }
    association :user
  end
end
