# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#users
first_user = User.create(name: 'Tom', photo: 'https://api.lorem.space/image/fashion?w=150&h=150&t=1', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://api.lorem.space/image/face?w=150&h=150&t=2', bio: 'Teacher from Poland.')

#posts
first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')

#comments
Comment.create(post: first_post, author: second_user, text: 'Hi Tom!' )