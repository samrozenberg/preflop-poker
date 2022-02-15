class RiverCardsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @hand = @game.hands.last
    @in_hand_players = []
    UserHand.where(hand: @hand, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    @used_cards = []
    @game.hands.last.user_cards.each do |user_card|
      @used_cards << user_card.deck_card
    end
    @game.hands.last.flop_cards.each do |flop_card|
      @used_cards << flop_card.deck_card
    end
    @game.hands.last.turn_cards.each do |turn_card|
      @used_cards << turn_card.deck_card
    end
    @available_cards = DeckCard.all - @used_cards
    RiverCard.create(hand: @hand, deck_card: @available_cards.sample)

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
      pokerhand = PokerHand.new(card_combination)
      user_hand.update_attribute(:rank, pokerhand.rank)

      if pokerhand > winning_poker_hand
        winning_poker_hand = pokerhand
        winners.clear
        winners << user_hand.user
      elsif pokerhand == winning_poker_hand
        winners << user_hand.user
      end
    end

    total_pot = 0
    @game.hands.last.users.each do |user|
      if user.bets.where(hand: @game.hands.last).last
        total_pot += user.bets.where(hand: @game.hands.last).last.amount
      end
    end

    if @game.hands[@game.hands.count - 2].remainder
      total_pot += @game.hands[@game.hands.count - 2].remainder
    end

    win_amount = total_pot/(winners.count)

    if total_pot.remainder(winners.count) != 0
      @game.hands.last.update_attribute(:remainder, total_pot.remainder(winners.count))
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
    end
    redirect_to game_path(@game)
  end
end
