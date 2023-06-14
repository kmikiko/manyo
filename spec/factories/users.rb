FactoryBot.define do
  factory :user do
    name { "user_name" }
    sequence(:email) { |n| "#{n}@example.com" }
    password {'111111'}
    password_confirmation {'111111'}
    admin { false }

  end
  factory :user2, class: User do
    name { "user_name2" }
    sequence(:email) { |n| "admin#{n}@example.com" }
    password {'111111'}
    password_confirmation {'111111'}
    admin { false }
  end
  factory :admin_user, class: User do
    name { "admin_user_name" }
    email { "admin_email@example.com" }
    password {'111111'}
    password_confirmation {'111111'}
    admin { true }
  end
end
