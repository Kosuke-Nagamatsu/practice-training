10.times do |n|
  name = Faker::JapaneseMedia::DragonBall.character
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password
               )
end
# User.create!(name:  "管理者",
#              email: "admin@example.jp",
#              password:  "password",
#              admin: true
#             )
