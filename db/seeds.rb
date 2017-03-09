# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:email => 'user@example.com', :password => '12345678', :role => 'user')
User.create(:email => 'moderator@example.com', :password => '12345678', :role => 'moderator')
User.create(:email => 'admin@example.com', :password => '12345678', :role => 'admin')
Note.create(:content => 'This is my note', :user_id => '3')
Note.create(:content => 'Hello there!', :user_id => '4')
Note.create(:content => 'A note', :user_id => '5')