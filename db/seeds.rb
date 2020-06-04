# frozen_string_literal: true

require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_user_test = {
  username: 'admin',
  name: 'Admin',
  location: 'Lima',
  email: 'admin@mail.com',
  bio: 'This is a test of Tuiteable user',
  password: 'admin1',
  password_confirmation: 'admin1'
}
puts 'Creating a Admin user...'
User.create!(admin_user_test)
puts 'Admin user was created !!'
puts 'Creating fakes users...'
20.times do
  username = Faker::Internet.username
  email = Faker::Internet.email(name: username)
  name = Faker::Name.name
  location = Faker::Address.city
  bio = Faker::Lorem.paragraphs(number: 1).to_s
  begin
    new_user = User.create!(username: username, email: email, name: name, password: '123456',
                            location: location, bio: bio,
                            password_confirmation: '123456')
  rescue StandardError => e
  end
end
puts 'Fakes users was created !!'
puts 'Creating fakes tuits...'
40.times do
  tuit = {}
  tuit[:body] = Faker::Lorem.paragraph
  tuit[:user] = User.all.sample
  begin
    tuit_test = Tuit.create!(tuit)
  rescue StandardError
    puts "ERROR, tuit #{tuit_test}was not created"
  end
end
puts 'Fakes tuits was created...'
puts 'Creating Fakes likes '
60.times do
  user = User.all.sample
  tuit = Tuit.all.sample
  begin
    Like.create!(user: user, tuit: tuit)
  rescue StandardError => e
    puts "ERROR, like not created, because #{e}"
  end
end
puts 'Fakes likes was created...'
puts 'Creating Fakes comments'
80.times do
  body = Faker::Lorem.paragraph
  user = User.all.sample
  tuit = Tuit.all.sample
  begin
    Comment.create!(user: user, tuit: tuit, body: body)
  rescue StandardError => e
    puts "Error, Comment was not created, because#{e} "
  end
end
puts 'Fakes comments was created...'
