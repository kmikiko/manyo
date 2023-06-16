User.create!(name: 'name',
             email: 'email@example.com',
             password: 'password',
             password_confirmation: 'password'
             )

User.create!(name:  '管理者',
             email: 'admin@example.com',
             password:  '111111',
           password_confirmation: '111111',
             admin: true)

labels = ['仕事', '家事', '家族', '友達', '学習', '読書', '外出用時', '買い物', 'キャリア', '記念日']
labels.each do |label_name|
  Label.create!(name: label_name)
end

users = []
10.times do |n|
  user = User.create!(
    email: "test_user_#{n + 1}@example.com",
    name: "テストユーザー#{n + 1}",
    password: "111111",
    password_confirmation: "111111"
  )
  users << user
end

10.times do |n|
  from = Date.parse("2023/07/01")
  to   = Date.parse("2023/12/31")
  Task.create!(
    name: "テスト#{n + 1}",
    detail: "何かする#{n + 1}",
    expired_at: Random.rand(from..to),
    status: ['完了', '着手中', '未着手'].sample,
    priority: [0, 1, 2].sample,
    user: users.sample
  )
end