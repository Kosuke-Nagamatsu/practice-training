10.times do |n|
  name = Faker::JapaneseMedia::DragonBall.character
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               admin: true
               )
end
10.times do |n|
  title = Faker::Food.fruits
  password = "password"
  Task.create!(title: title,
               content: "テスト",
               time_limit: "2021-08-30 10:00:00",
               status: rand(1..3),
               priority: rand(1..3),
               user_id: rand(1..10)
               )
end
labels = ["社外", "社内", "チーム", "個人", "緊急", "高高高", "雑務", "訪問", "出張", "チェック待ち"]
labels.each do |l|
  Label.create!(name: l)
end
# 0.times do |i|
#   Label.create!(name: "sample#{i + 1}")
# end
