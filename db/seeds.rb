# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Package.create(name: "Basic", contacts_allowed: 5, price: 10)
Package.create(name: "Standard", contacts_allowed: 8, price: 15)
Package.create(name: "Premium", contacts_allowed: 15, price: 25)
Package.create(name: "Free", contacts_allowed: 1, price: 0)