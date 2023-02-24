FactoryBot.define do
  factory :card do
    front { "アジャイル開発" }
    back { "web自社開発等の現場において、トライアンドエラーを短いサイクルで行う開発形態" }
    association :user
  end
end
