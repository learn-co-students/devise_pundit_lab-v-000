# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'user@1.com')
User.create(email: 'user@2.com')

Note.create(content: 'Note 1', user_id: 1)
Note.create(content: 'Note 2', user_id: 1)
Note.create(content: 'Note 3', user_id: 1)
Note.create(content: 'Note 4', user_id: 1)
Note.create(content: 'Note 1', user_id: 2)
Note.create(content: 'Note 4', user_id: 2)
Note.create(content: 'Note 2', user_id: 2)
Note.create(content: 'Note 3', user_id: 2)
