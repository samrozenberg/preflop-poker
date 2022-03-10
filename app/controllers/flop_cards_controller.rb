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


    @current_hand = @game.hands.last

    if @hand.name == "Texas"
      @combinations = @combination_available_cards.combination(2).to_a.sample(300)
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
    elsif @hand.name == "Omaha 4"
      @combinations = @combination_available_cards.combination(2).to_a.sample(100)
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
          player_best_pokerhand = PokerHand.new("")
          instance_variable_get("@#{player.pseudo}_cards").combination(2).to_a.each do |two_card_combination|
            # instance_variable_set("@#{player.pseudo}_pokerhand", PokerHand.new(two_card_combination))
            board_cards = []
            combination.each do |card|
              # instance_variable_get("@#{player.pseudo}_pokerhand") << card.code
              board_cards << card.code
            end
            # instance_variable_get("@#{player.pseudo}_pokerhand") << @flop_cards_codes
            board_cards += @flop_cards_codes

            best_combination = PokerHand.new("")

            board_cards.combination(3).to_a.each do |combi|
              pokerhand_five = PokerHand.new(two_card_combination)
              pokerhand_five << combi
              if pokerhand_five > best_combination
                best_combination = pokerhand_five
              end
            end

            if best_combination > player_best_pokerhand
              player_best_pokerhand = best_combination
            end
          end
          if player_best_pokerhand > winning_simulation
            winning_simulation = player_best_pokerhand
            winning_player.clear
            winning_player << player
          elsif player_best_pokerhand == winning_simulation
            winning_player << player
          end
        end
        winning_player.each do |player|
          @winners << player
        end
      end

      UserHand.where(user: @in_hand_players, hand: @hand).each do |user_hand|
        best_pokerhand = PokerHand.new("")
        user_four_cards = []
        UserCard.where(user: user_hand.user, hand: @hand).each do |user_card|
          user_four_cards << user_card.deck_card.code
        end
        user_four_cards.combination(2).to_a.each do |two_card_combination|
          pokerhand = PokerHand.new(two_card_combination)
          FlopCard.where(hand: @hand).each do |card|
            pokerhand << card.deck_card.code
          end
          if pokerhand > best_pokerhand
            best_pokerhand = pokerhand
          end
        end
        user_hand.update_attribute(:rank, best_pokerhand.rank)
        odd = (@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1) % 1 == 0 ? "#{(@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1).to_i}%" : "#{(@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1)}%"
        user_hand.update_attribute(:odds, odd)
      end
    elsif @hand.name == "Omaha 5"
      @combinations = @combination_available_cards.combination(2).to_a.sample(50)
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
          player_best_pokerhand = PokerHand.new("")
          instance_variable_get("@#{player.pseudo}_cards").combination(2).to_a.each do |two_card_combination|
            board_cards = []
            combination.each do |card|
              board_cards << card.code
            end
            board_cards += @flop_cards_codes

            best_combination = PokerHand.new("")

            board_cards.combination(3).to_a.each do |combi|
              pokerhand_five = PokerHand.new(two_card_combination)
              pokerhand_five << combi
              if pokerhand_five > best_combination
                best_combination = pokerhand_five
              end
            end

            if best_combination > player_best_pokerhand
              player_best_pokerhand = best_combination
            end
          end
          if player_best_pokerhand > winning_simulation
            winning_simulation = player_best_pokerhand
            winning_player.clear
            winning_player << player
          elsif player_best_pokerhand == winning_simulation
            winning_player << player
          end
        end
        winning_player.each do |player|
          @winners << player
        end
      end

      UserHand.where(user: @in_hand_players, hand: @hand).each do |user_hand|
        best_pokerhand = PokerHand.new("")
        user_five_cards = []
        UserCard.where(user: user_hand.user, hand: @hand).each do |user_card|
          user_five_cards << user_card.deck_card.code
        end
        user_five_cards.combination(2).to_a.each do |two_card_combination|
          pokerhand = PokerHand.new(two_card_combination)
          FlopCard.where(hand: @hand).each do |card|
            pokerhand << card.deck_card.code
          end
          if pokerhand > best_pokerhand
            best_pokerhand = pokerhand
          end
        end
        user_hand.update_attribute(:rank, best_pokerhand.rank)
        odd = (@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1) % 1 == 0 ? "#{(@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1).to_i}%" : "#{(@winners.count(user_hand.user) / @combinations.count.to_f * 100).round(1)}%"
        user_hand.update_attribute(:odds, odd)
      end
    end

    GameChannel.broadcast_to(
      @game,
      @hand.flop_cards
    )

    redirect_to game_path(@game)
  end
end
