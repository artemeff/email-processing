# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

author = User.create!(email: 'author@dev')
commenter = User.create!(name: 'John Doe', email: 'john.doe@dev')

post = Post.create!(user: author, title: 'test post',
  text: 'Really interesting text about something...')
Comment.create!(user: commenter, post: post, text: 'about what?')
