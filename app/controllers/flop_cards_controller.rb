class FlopCardsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @hand = @game.hands.last
    @used_cards = []
    @hand.user_cards.each do |user_card|
      @used_cards << user_card.deck_card
    end
    @available_cards = DeckCard.all - @used_cards
    @available_cards.sample(3).each do |card|
      FlopCard.create(hand: @hand, deck_card: card)
    end
    redirect_to game_path(@game)
  end
end
