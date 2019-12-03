# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name:"luis", email: "luis@example.com", password:'password')
creator = User.create(name:'Mike', email:'mikew@monsterinc.com', password:'wasausky')
User.create(name:'Sulley', email:'sulley@monsterinc.com', password:'Sullivan')
User.create(name:'Boo', email:'boo@monsterinc.com', password:'imababy')
creator.events.create(name: "Costumes's Party", description: 'everyone should use a costume')
creator.events.create(name: "Mike's Birthday", description: 'sully is going to bring the cake')