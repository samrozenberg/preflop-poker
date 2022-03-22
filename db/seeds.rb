# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Cleaning database... lets gooooooo 🗑🕺"

@hands_not_to_update = []

User.all.each do |user|
  if !@hands_not_to_update.include?(user.best_hand)
    @hands_not_to_update << user.best_hand
  end
  if !@hands_not_to_update.include?(user.worst_hand)
    @hands_not_to_update << user.worst_hand
  end
end

(Hand.all - Hand.last(50) - @hands_not_to_update).each do |hand|
  hand.flop_cards.each do |flop_card|
    flop_card.destroy
  end
  hand.turn_cards.each do |turn_card|
    turn_card.destroy
  end
  hand.river_cards.each do |river_card|
    river_card.destroy
  end
  hand.user_cards.each do |user_card|
    user_card.destroy
  end
end

# UserCard.destroy_all
# puts "UserCards destroyed ✅"

# FlopCard.destroy_all
# puts "FlopCards destroyed ✅"

# TurnCard.destroy_all
# puts "TurnCards destroyed ✅"

# RiverCard.destroy_all
# puts "RiverCards destroyed ✅"

# DeckCard.destroy_all
# puts "DeckCards destroyed ✅"





# card1 = { name: "A❤️", url: "ace_of_hearts.png", code: "Ah" }
# card2 = { name: "2❤️", url: "2_of_hearts.png", code: "2h" }
# card3 = { name: "3❤️", url: "3_of_hearts.png", code: "3h" }
# card4 = { name: "4❤️", url: "4_of_hearts.png", code: "4h" }
# card5 = { name: "5❤️", url: "5_of_hearts.png", code: "5h" }
# card6 = { name: "6❤️", url: "6_of_hearts.png", code: "6h" }
# card7 = { name: "7❤️", url: "7_of_hearts.png", code: "7h" }
# card8 = { name: "8❤️", url: "8_of_hearts.png", code: "8h" }
# card9 = { name: "9❤️", url: "9_of_hearts.png", code: "9h" }
# card10 = { name: "10❤️", url: "10_of_hearts.png", code: "Th" }
# card11 = { name: "J❤️", url: "jack_of_hearts.png", code: "Jh" }
# card12 = { name: "Q❤️", url: "queen_of_hearts.png", code: "Qh" }
# card13 = { name: "K❤️", url: "king_of_hearts.png", code: "Kh" }
# card14 = { name: "A♣️", url: "ace_of_clubs.png", code: "Ac" }
# card15 = { name: "2♣️", url: "2_of_clubs.png", code: "2c" }
# card16 = { name: "3♣️", url: "3_of_clubs.png", code: "3c" }
# card17 = { name: "4♣️", url: "4_of_clubs.png", code: "4c" }
# card18 = { name: "5♣️", url: "5_of_clubs.png", code: "5c" }
# card19 = { name: "6♣️", url: "6_of_clubs.png", code: "6c" }
# card20 = { name: "7♣️", url: "7_of_clubs.png", code: "7c" }
# card21 = { name: "8♣️", url: "8_of_clubs.png", code: "8c" }
# card22 = { name: "9♣️", url: "9_of_clubs.png", code: "9c" }
# card23 = { name: "10♣️", url: "10_of_clubs.png", code: "Tc" }
# card24 = { name: "J♣️", url: "jack_of_clubs.png", code: "Jc" }
# card25 = { name: "Q♣️", url: "queen_of_clubs.png", code: "Qc" }
# card26 = { name: "K♣️", url: "king_of_clubs.png", code: "Kc" }
# card27 = { name: "A♠", url: "ace_of_spades.png", code: "As" }
# card28 = { name: "2♠", url: "2_of_spades.png", code: "2s" }
# card29 = { name: "3♠", url: "3_of_spades.png", code: "3s" }
# card30 = { name: "4♠", url: "4_of_spades.png", code: "4s" }
# card31 = { name: "5♠", url: "5_of_spades.png", code: "5s" }
# card32 = { name: "6♠", url: "6_of_spades.png", code: "6s" }
# card33 = { name: "7♠", url: "7_of_spades.png", code: "7s" }
# card34 = { name: "8♠", url: "8_of_spades.png", code: "8s" }
# card35 = { name: "9♠", url: "9_of_spades.png", code: "9s" }
# card36 = { name: "10♠", url: "10_of_spades.png", code: "Ts" }
# card37 = { name: "J♠", url: "jack_of_spades.png", code: "Js" }
# card38 = { name: "Q♠", url: "queen_of_spades.png", code: "Qs" }
# card39 = { name: "K♠", url: "king_of_spades.png", code: "Ks" }
# card40 = { name: "A♦️", url: "ace_of_diamonds.png", code: "Ad" }
# card41 = { name: "2♦️", url: "2_of_diamonds.png", code: "2d" }
# card42 = { name: "3♦️", url: "3_of_diamonds.png", code: "3d" }
# card43 = { name: "4♦️", url: "4_of_diamonds.png", code: "4d" }
# card44 = { name: "5♦️", url: "5_of_diamonds.png", code: "5d" }
# card45 = { name: "6♦️", url: "6_of_diamonds.png", code: "6d" }
# card46 = { name: "7♦️", url: "7_of_diamonds.png", code: "7d" }
# card47 = { name: "8♦️", url: "8_of_diamonds.png", code: "8d" }
# card48 = { name: "9♦️", url: "9_of_diamonds.png", code: "9d" }
# card49 = { name: "10♦️", url: "10_of_diamonds.png", code: "Td" }
# card50 = { name: "J♦️", url: "jack_of_diamonds.png", code: "Jd" }
# card51 = { name: "Q♦️", url: "queen_of_diamonds.png", code: "Qd" }
# card52 = { name: "K♦️", url: "king_of_diamonds.png", code: "Kd" }

# [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13, card14, card15, card16, card17, card18, card19, card20, card21, card22, card23, card24, card25, card26, card27, card28, card29, card30, card31, card32, card33, card34, card35, card36, card37, card38, card39, card40, card41, card42, card43, card44, card45, card46, card47, card48, card49, card50, card51, card52].each do |attributes|
#   card = DeckCard.create!(attributes)
#   puts "Created #{card.name}"
# end

# puts 'Creating users...'

# user1 = { name: "Sam Rozen", pseudo: "samrozen", email: "sam@preflop.com", password: "helloo", password_confirmation: "helloo" }
# user2 = { name: "Scott Lichten", pseudo: "scotti", email: "scott@preflop.com", password: "helloo", password_confirmation: "helloo" }

# [user1, user2].each do |attributes|
#   user = User.create!(attributes)
#   puts "Created #{user.name}"
# end
