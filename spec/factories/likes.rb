FactoryBot.define do
  factory :like do
    association :card
    user { card.user }
  end
end
