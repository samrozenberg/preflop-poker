# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Cleaning database... lets gooooooo 🗑🕺"
Card.destroy_all
puts "Cards destroyed ✅"
User.destroy_all
puts "Users destroyed ✅"

puts 'Creating users...'


card1 = { name: "A❤️" }
card2 = { name: "2❤️" }
card3 = { name: "3❤️" }
card4 = { name: "4❤️" }
card5 = { name: "5❤️" }
card6 = { name: "6❤️" }
card7 = { name: "7❤️" }
card8 = { name: "8❤️" }
card9 = { name: "9❤️" }
card10 = { name: "10❤️" }
card11 = { name: "J❤️" }
card12 = { name: "Q❤️" }
card13 = { name: "K❤️" }
card14 = { name: "A♣️" }
card15 = { name: "2♣️" }
card16 = { name: "3♣️" }
card17 = { name: "4♣️" }
card18 = { name: "5♣️" }
card19 = { name: "6♣️" }
card20 = { name: "7♣️" }
card21 = { name: "8♣️" }
card22 = { name: "9♣️" }
card23 = { name: "10♣️" }
card24 = { name: "J♣️" }
card25 = { name: "Q♣️" }
card26 = { name: "K♣️" }
card27 = { name: "A♠" }
card28 = { name: "2♠" }
card29 = { name: "3♠" }
card30 = { name: "4♠" }
card31 = { name: "5♠" }
card32 = { name: "6♠" }
card33 = { name: "7♠" }
card34 = { name: "8♠" }
card35 = { name: "9♠" }
card36 = { name: "10♠" }
card37 = { name: "J♠" }
card38 = { name: "Q♠" }
card39 = { name: "K♠" }
card40 = { name: "A♦️" }
card41 = { name: "2♦️" }
card42 = { name: "3♦️" }
card43 = { name: "4♦️" }
card44 = { name: "5♦️" }
card45 = { name: "6♦️" }
card46 = { name: "7♦️" }
card47 = { name: "8♦️" }
card48 = { name: "9♦️" }
card49 = { name: "10♦️" }
card50 = { name: "J♦️" }
card51 = { name: "Q♦️" }
card52 = { name: "K♦️" }

[card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13, card14, card15, card16, card17, card18, card19, card20, card21, card22, card23, card24, card25, card26, card27, card28, card29, card30, card31, card32, card33, card34, card35, card36, card37, card38, card39, card40, card41, card42, card43, card44, card45, card46, card47, card48, card49, card50, card51, card52].each do |attributes|
  card = Card.create!(attributes)
  puts "Created #{card.name}"
end

puts 'Creating users...'

user1 = { name: "Sam Rozen", pseudo: "samrozen", email: "sam@preflop.com", password: "helloo", password_confirmation: "helloo" }
user2 = { name: "Scott Lichten", pseudo: "scotti", email: "scott@preflop.com", password: "helloo", password_confirmation: "helloo" }

[user1, user2].each do |attributes|
  user = User.create!(attributes)
  puts "Created #{user.name}"
end
