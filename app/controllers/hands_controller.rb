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



# determiner au moment de l'initialisation d'une main la turn et la river aussi mais en mettant un "", puis l'updater en appuyant sur la bouton
# peut-être pas nécessaire pcq turn_card et river card == nil ?
