1.times do |n|
  name = Faker::JapaneseMedia::DragonBall.character
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password
               )
end
