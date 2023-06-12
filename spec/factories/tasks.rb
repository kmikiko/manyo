FactoryBot.define do
  factory :task do
    name { |i| "test_name#{i}" }
    detail { |i| "test_detail#{i}" }
    from = Date.parse("2023/07/01")
    to   = Date.parse("2023/12/31")
    expired_at { Random.rand(from..to) }
    status {['完了', '着手中', '未着手'].sample}
  end
  
end
