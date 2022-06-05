# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.create!(name: "Category",
description: "Some category description")

31.times do |n|
  name = "Category#{n+1}"
  description = "Some category description#{n+1}"
  Category.create!(name: name, 
  description: description)  
end

Library.create!(
  name: "Libname",
  url: "https://github.com/Overbryd/exoml",
  stars: 50,
  last_commit: 25,
  category_id: 1,
  description: "Some library description")

150.times do |m|
  name = "Libname#{m+1}"
  url = "https://github.com/Overbryd/exoml#{m+1}"
  stars = rand(3000)
  last_commit = rand(365)
  category_id = rand(30) + 1
  Library.create!(name: name,
  url: url,
  stars: stars,
  last_commit: last_commit,
  category_id: category_id,
  description: "Some library description#{m+1}")
end
