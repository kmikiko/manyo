FactoryBot.define do
  factory :task do
    name { 'test_name' }
    detail { 'test_detail' }
    from = Date.parse("2023/07/01")
    to   = Date.parse("2023/12/31")
    expired_at { Random.rand(from..to) }
    status {'未着手'}
  end
end
