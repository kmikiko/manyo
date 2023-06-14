FactoryBot.define do
  factory :user do
    name { "user_name" }
    email { "email@example.com" }
    password {'111111'}
    password_confirmation {'111111'}
    admin { true }
  end
  factory :admin_user do
    name { "admin_user_name" }
    email { "admin_email@example.com" }
    password {'111111'}
    password_confirmation {'111111'}
    admin { false }
  end
end
