require 'faker'

50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
end 

wikis = Wiki.all

admin = User.new(
  name:      'Admin User',
  email:     'admin@example.com',
  password:  'helloworld',
  role:      'admin'
)

admin.skip_confirmation!
admin.save!

standard = User.new(
  name:     'Standard User',
  email:    'standard@example.com',
  password: 'helloworld',
  role:     'moderator'
)
standard.skip_confirmation!
standard.save!

premium = User.new(
  name:       'Premium User',
  email:      'premium@example.com',
  password:   'helloworld'
)
premium.skip_confirmation!
premium.save!

10.times do
  user = User.new(
    name:       Faker::Name.name,
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end 
users = User.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
