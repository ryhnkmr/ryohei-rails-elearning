require "faker"

User.create(
    name: "test user",
    email: "test@gmail.com",
    password: "password"
)

50.times do |n|
  User.create(
    name:Faker::Science.scientist,
    email: Faker::Internet.unique.email,
    password: "password"
  )
end

