class RiverCardsController < ApplicationController
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
    DeletedCard.where(hand: @hand).each do |card|
      @used_cards << card.deck_card
    end
    @hand.flop_cards.each do |flop_card|
      @used_cards << flop_card.deck_card
    end
    @hand.turn_cards.each do |turn_card|
      @used_cards << turn_card.deck_card
    end
    @available_cards = DeckCard.all - @used_cards
    RiverCard.create(hand: @hand, deck_card: @available_cards.sample)

    if @hand.name == "Texas" || @hand.name == "Pineapple" || @hand.name == "Sutra"
      winning_poker_hand = PokerHand.new("")
      winners = []

      UserHand.where(user: @in_hand_players, hand: @hand).each do |user_hand|
        card_combination = []
        UserCard.where(user: user_hand.user, hand: @hand).each do |card|
          card_combination << card.deck_card.code
        end
        FlopCard.where(hand: @hand).each do |card|
          card_combination << card.deck_card.code
        end
        TurnCard.where(hand: @hand).each do |card|
          card_combination << card.deck_card.code
        end
        RiverCard.where(hand: @hand).each do |card|
          card_combination << card.deck_card.code
        end
        ph = PokerHand.new(card_combination)
        pokerhand = PokerHand.new(ph.sort_using_rank[0, 14])
        user_hand.update_attribute(:rank, pokerhand.rank)

        if pokerhand > winning_poker_hand
          winning_poker_hand = pokerhand
          winners.clear
          winners << user_hand.user
        elsif pokerhand == winning_poker_hand
          winners << user_hand.user
        end
      end
    elsif @hand.name == "Omaha 4"
      winning_poker_hand = PokerHand.new("")
      winners = []

      UserHand.where(user: @in_hand_players, hand: @hand).each do |user_hand|
        best_pokerhand = PokerHand.new("")
        user_four_cards = []
        UserCard.where(user: user_hand.user, hand: @hand).each do |user_card|
          user_four_cards << user_card.deck_card.code
        end
        all_board_cards = []
        FlopCard.where(hand: @hand).each do |card|
          all_board_cards << card.deck_card.code
        end
        TurnCard.where(hand: @hand).each do |card|
          all_board_cards << card.deck_card.code
        end
        RiverCard.where(hand: @hand).each do |card|
          all_board_cards << card.deck_card.code
        end
        user_four_cards.combination(2).to_a.each do |two_card_combination|
          best_player_combination = PokerHand.new("")
          all_board_cards.combination(3).to_a.each do |combi|
            pokerhand_five = PokerHand.new(two_card_combination)
            pokerhand_five << combi
            if pokerhand_five > best_player_combination
              best_player_combination = pokerhand_five
            end
          end
          if best_player_combination > best_pokerhand
            best_pokerhand = best_player_combination
          end
        end
        if best_pokerhand > winning_poker_hand
          winning_poker_hand = best_pokerhand
          winners.clear
          winners << user_hand.user
        elsif best_pokerhand == winning_poker_hand
          winners << user_hand.user
        end
        user_hand.update_attribute(:rank, best_pokerhand.rank)
      end
    elsif @hand.name == "Omaha 5"
      winning_poker_hand = PokerHand.new("")
      winners = []

      UserHand.where(user: @in_hand_players, hand: @hand).each do |user_hand|
        best_pokerhand = PokerHand.new("")
        user_five_cards = []
        UserCard.where(user: user_hand.user, hand: @hand).each do |user_card|
          user_five_cards << user_card.deck_card.code
        end
        all_board_cards = []
        FlopCard.where(hand: @hand).each do |card|
          all_board_cards << card.deck_card.code
        end
        TurnCard.where(hand: @hand).each do |card|
          all_board_cards << card.deck_card.code
        end
        RiverCard.where(hand: @hand).each do |card|
          all_board_cards << card.deck_card.code
        end
        user_five_cards.combination(2).to_a.each do |two_card_combination|
          best_player_combination = PokerHand.new("")
          all_board_cards.combination(3).to_a.each do |combi|
            pokerhand_five = PokerHand.new(two_card_combination)
            pokerhand_five << combi
            if pokerhand_five > best_player_combination
              best_player_combination = pokerhand_five
            end
          end
          if best_player_combination > best_pokerhand
            best_pokerhand = best_player_combination
          end
        end
        if best_pokerhand > winning_poker_hand
          winning_poker_hand = best_pokerhand
          winners.clear
          winners << user_hand.user
        elsif best_pokerhand == winning_poker_hand
          winners << user_hand.user
        end
        user_hand.update_attribute(:rank, best_pokerhand.rank)
      end
    end



    total_pot = 0
    @hand.users.each do |user|
      if user.bets.where(hand: @hand).last
        total_pot += user.bets.where(hand: @hand).last.amount
      end
    end

    if @game.hands.order(:created_at)[@game.hands.count - 2] && @game.hands.order(:created_at)[@game.hands.count - 2].remainder
      total_pot += @game.hands.order(:created_at)[@game.hands.count - 2].remainder
    end

    @game.amount_played += total_pot
    @game.save

    win_amount = total_pot/(winners.count)

    if total_pot.remainder(winners.count) != 0
      @hand.update_attribute(:remainder, total_pot.remainder(winners.count))
    end

    winners.each do |winner|
      HandWinner.create(hand: @hand, winner: winner)
    end

    @game.reservations.where(active: true).each do |reservation|
      resa = @game.reservations.where(user: reservation.user)[0]
      if winners.include?(reservation.user)
        resa.score += win_amount
      else
        resa.score += 1
        resa.save
        resa.score -= 1
      end
      resa.save
    end

    @in_hand_players.each do |player|
      if winners.include?(player)
        UserHand.where(hand: @hand, user: player)[0].update_attribute(:odds, "100%")
      else
        UserHand.where(hand: @hand, user: player)[0].update_attribute(:odds, "0%")
      end
      player.hand_not_folded += 1
      player.save
    end

    @active_players = []
    @game.reservations.where(active: true).order(:created_at).each do |reservation|
      @active_players << reservation.user
    end

    @active_players.each do |player|
      if player.best_hand == nil
        player.update_attribute(:best_hand, @hand)
        player.update_attribute(:worst_hand, @hand)
        if winners.include?(player)
          player.hand_won += 1
          player.save
          player.update_attribute(:biggest_win, win_amount - @hand.bets.where(user: player).last.amount)
          player.update_attribute(:biggest_loss, 0)
        else
          player.update_attribute(:biggest_win, 0)
          player.update_attribute(:biggest_loss, @hand.bets.where(user: player).last.amount)
        end
      elsif @hand.bets.where(user: player).last
        if winners.include?(player)
          player.hand_won += 1
          player.save
          if @hand.pot - @hand.bets.where(user: player).last.amount > player.biggest_win
            player.update_attribute(:biggest_win, win_amount - @hand.bets.where(user: player).last.amount)
            player.update_attribute(:best_hand, @hand)
          end
        else
          if @hand.bets.where(user: player).last && @hand.bets.where(user: player).last.amount > player.biggest_loss
            player.update_attribute(:biggest_loss, @hand.bets.where(user: player).last.amount)
            player.update_attribute(:worst_hand, @hand)
          end
        end
      end
    end

    GameChannel.broadcast_to(
      @game,
      @hand.river_cards
    )

    redirect_to game_path(@game)
  end
end
