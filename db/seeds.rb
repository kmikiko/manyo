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