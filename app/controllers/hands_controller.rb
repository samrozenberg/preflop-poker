class HandsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @hand = Hand.new(game: @game)
    @hand.save!
    @hand.cards = Card.all.sample((@game.users.count * 2) + 5)
    # (hand_params)
    redirect_to game_path(@game)
  end

  # private

  # def hand_params
  #   params.require(:hand).permit(:active)
  # end
end
