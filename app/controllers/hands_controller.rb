class HandsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @hand = Hand.new(game: @game)
    @cards = Card.all.sample(11)
    # (hand_params)
    @hand.save!
    redirect_to game_path(@game)
  end

  # private

  # def hand_params
  #   params.require(:hand).permit(:active)
  # end
end
