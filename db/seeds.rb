User.destroy_all
Wiki.destroy_all

# Create users
usernames = ["Bert", "Ernie", "Calvin", "Hobbes"]
emails = ["bert@example.com", "ernie@example.com", "calvin@user.com", "hobbes@tiger.com"]

4.times do |i|
  User.create!(
  username: usernames[i],
  email:    emails[i],
  password: "password"
  )
end

User.create!(
username: "admin",
email:    "admin@example.com",
password: "password",
role:     2
)

users = User.all

80.times do
  Wiki.create!(
  title:  Faker::Hacker.adjective,
  body:   Faker::Hacker.say_something_smart,
  private: [true, false].sample,
  user:   users.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
