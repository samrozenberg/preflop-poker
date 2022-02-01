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
        current_winner = user_hand.user
      elsif pokerhand == winning_poker_hand
        winner2 = user_hand.user
        @hand.update_attribute(:winner2, winner2)
      end
    end


    HandWinner.create(hand: @hand, winner: )
    # @hand.update_attribute(:winner)

    redirect_to game_path(@game)
  end
end
