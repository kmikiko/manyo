FactoryBot.define do
  factory :notification do
    user { nil }
    task { nil }
    action { "" }
    checked { false }
  end
end
