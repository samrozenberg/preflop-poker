# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Cleaning database... lets gooooooo 🗑🕺"
UserCard.destroy_all
puts "UserCards destroyed ✅"

FlopCard.destroy_all
puts "FlopCards destroyed ✅"

TurnCard.destroy_all
puts "TurnCards destroyed ✅"

RiverCard.destroy_all
puts "RiverCards destroyed ✅"

DeckCard.destroy_all
puts "DeckCards destroyed ✅"
# User.destroy_all
# puts "Users destroyed ✅"




card1 = { name: "A❤️", url: "ace_of_hearts.png" }
card2 = { name: "2❤️", url: "2_of_hearts.png" }
card3 = { name: "3❤️", url: "3_of_hearts.png" }
card4 = { name: "4❤️", url: "4_of_hearts.png" }
card5 = { name: "5❤️", url: "5_of_hearts.png" }
card6 = { name: "6❤️", url: "6_of_hearts.png" }
card7 = { name: "7❤️", url: "7_of_hearts.png" }
card8 = { name: "8❤️", url: "8_of_hearts.png" }
card9 = { name: "9❤️", url: "9_of_hearts.png" }
card10 = { name: "10❤️", url: "10_of_hearts.png" }
card11 = { name: "J❤️", url: "jack_of_hearts.png" }
card12 = { name: "Q❤️", url: "queen_of_hearts.png" }
card13 = { name: "K❤️", url: "king_of_hearts.png" }
card14 = { name: "A♣️", url: "ace_of_clubs.png" }
card15 = { name: "2♣️", url: "2_of_clubs.png" }
card16 = { name: "3♣️", url: "3_of_clubs.png" }
card17 = { name: "4♣️", url: "4_of_clubs.png" }
card18 = { name: "5♣️", url: "5_of_clubs.png" }
card19 = { name: "6♣️", url: "6_of_clubs.png" }
card20 = { name: "7♣️", url: "7_of_clubs.png" }
card21 = { name: "8♣️", url: "8_of_clubs.png" }
card22 = { name: "9♣️", url: "9_of_clubs.png" }
card23 = { name: "10♣️", url: "10_of_clubs.png" }
card24 = { name: "J♣️", url: "jack_of_clubs.png" }
card25 = { name: "Q♣️", url: "queen_of_clubs.png" }
card26 = { name: "K♣️", url: "king_of_clubs.png" }
card27 = { name: "A♠", url: "ace_of_spades.png" }
card28 = { name: "2♠", url: "2_of_spades.png" }
card29 = { name: "3♠", url: "3_of_spades.png" }
card30 = { name: "4♠", url: "4_of_spades.png" }
card31 = { name: "5♠", url: "5_of_spades.png" }
card32 = { name: "6♠", url: "6_of_spades.png" }
card33 = { name: "7♠", url: "7_of_spades.png" }
card34 = { name: "8♠", url: "8_of_spades.png" }
card35 = { name: "9♠", url: "9_of_spades.png" }
card36 = { name: "10♠", url: "10_of_spades.png" }
card37 = { name: "J♠", url: "jack_of_spades.png" }
card38 = { name: "Q♠", url: "queen_of_spades.png" }
card39 = { name: "K♠", url: "king_of_spades.png" }
card40 = { name: "A♦️", url: "ace_of_diamonds.png" }
card41 = { name: "2♦️", url: "2_of_diamonds.png" }
card42 = { name: "3♦️", url: "3_of_diamonds.png" }
card43 = { name: "4♦️", url: "4_of_diamonds.png" }
card44 = { name: "5♦️", url: "5_of_diamonds.png" }
card45 = { name: "6♦️", url: "6_of_diamonds.png" }
card46 = { name: "7♦️", url: "7_of_diamonds.png" }
card47 = { name: "8♦️", url: "8_of_diamonds.png" }
card48 = { name: "9♦️", url: "9_of_diamonds.png" }
card49 = { name: "10♦️", url: "10_of_diamonds.png" }
card50 = { name: "J♦️", url: "jack_of_diamonds.png" }
card51 = { name: "Q♦️", url: "queen_of_diamonds.png" }
card52 = { name: "K♦️", url: "king_of_diamonds.png" }

[card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13, card14, card15, card16, card17, card18, card19, card20, card21, card22, card23, card24, card25, card26, card27, card28, card29, card30, card31, card32, card33, card34, card35, card36, card37, card38, card39, card40, card41, card42, card43, card44, card45, card46, card47, card48, card49, card50, card51, card52].each do |attributes|
  card = DeckCard.create!(attributes)
  puts "Created #{card.name}"
end

# puts 'Creating users...'

# user1 = { name: "Sam Rozen", pseudo: "samrozen", email: "sam@preflop.com", password: "helloo", password_confirmation: "helloo" }
# user2 = { name: "Scott Lichten", pseudo: "scotti", email: "scott@preflop.com", password: "helloo", password_confirmation: "helloo" }

# [user1, user2].each do |attributes|
#   user = User.create!(attributes)
#   puts "Created #{user.name}"
# end
