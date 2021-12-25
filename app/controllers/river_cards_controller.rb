class RiverCardsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @hand = @game.hands.last
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
    redirect_to game_path(@game)
  end
end
