class FlopCardsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @hand = @game.hands.last
    @in_hand_players = []
    UserHand.where(hand: @hand, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    @used_cards = []
    @hand.user_cards.each do |user_card|
      @used_cards << user_card.deck_card
    end
    @available_cards = DeckCard.all - @used_cards
    @available_cards.sample(3).each do |card|
      FlopCard.create(hand: @hand, deck_card: card)
    end

    @flop_cards = []
    @hand.flop_cards.each do |card|
      @flop_cards << card.deck_card
    end
    @combination_available_cards = @available_cards - @flop_cards
    @combinations = @combination_available_cards.combination(2).to_a.sample(300)

    @current_hand = @game.hands.last

    @in_hand_players.each do |player|
      instance_variable_set("@#{player.pseudo}_cards", [])
      UserCard.where(hand: @current_hand, user: player).each do |card|
        instance_variable_get("@#{player.pseudo}_cards") << card.deck_card.code
      end
    end

    @winners = []
    @flop_cards_codes = []
    @flop_cards.each do |card|
      @flop_cards_codes << card.code
    end
    @combinations.each do |combination|
      winning_simulation = PokerHand.new("")
      winning_player = []
      @in_hand_players.each do |player|
        instance_variable_set("@#{player.pseudo}_pokerhand", PokerHand.new(instance_variable_get("@#{player.pseudo}_cards")))
        combination.each do |card|
          instance_variable_get("@#{player.pseudo}_pokerhand") << card.code
        end
        instance_variable_get("@#{player.pseudo}_pokerhand") << @flop_cards_codes
        if instance_variable_get("@#{player.pseudo}_pokerhand") > winning_simulation
          winning_simulation = instance_variable_get("@#{player.pseudo}_pokerhand")
          winning_player.clear
          winning_player << player
        elsif instance_variable_get("@#{player.pseudo}_pokerhand") == winning_simulation
          winning_player << player
        end
      end
      winning_player.each do |player|
        @winners << player
      end
    end


    UserHand.where(user: @in_hand_players, hand: @hand).each do |user_hand|
      card_combination = []
      UserCard.where(user: user_hand.user, hand: @hand).each do |card|
        card_combination << card.deck_card.code
      end
      FlopCard.where(hand: @hand).each do |card|
        card_combination << card.deck_card.code
      end
      pokerhand = PokerHand.new(card_combination)
      user_hand.update_attribute(:rank, pokerhand.rank)
      odd = (@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1) % 1 == 0 ? "#{(@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1).to_i}%" : "#{(@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1)}%"
      user_hand.update_attribute(:odds, odd)
    end

    redirect_to game_path(@game)
  end
end
