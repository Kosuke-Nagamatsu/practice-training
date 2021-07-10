labels = ["社外", "社内", "チーム", "個人"]
labels.each do |l|
  Label.create!(name: l)
end
# 0.times do |i|
#   Label.create!(name: "sample#{i + 1}")
# end
