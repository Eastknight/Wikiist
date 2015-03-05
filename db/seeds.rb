require 'faker'

standard = User.new(
  name: 'Standard User',
  email: 'standard@example.com',
  password: 'helloworld',
  role: 'standard'
)
standard.skip_confirmation!
standard.save!

premium = User.new(
  name: 'Premium User',
  email: 'premium@example.com',
  password: 'helloworld',
  role: 'premium'
)
premium.skip_confirmation!
premium.save!

lei = User.new(
  name: 'Lei Chen',
  email: 'lei.chen.scu@gmail.com',
  password: 'helloworld',
  role: 'premium'
)
lei.skip_confirmation!
lei.save!


5.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

50.times do
  Wiki.create!(
    title: Faker::Lorem.word,
    body: Faker::Lorem.paragraph,
    user: users.sample,
    private: false
  )
end

50.times do
  Wiki.create!(
    title: Faker::Lorem.word,
    body: Faker::Lorem.paragraph,
    user: users.sample,
    private: true
  )
end

admin = User.new(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)
admin.skip_confirmation!
admin.save!

