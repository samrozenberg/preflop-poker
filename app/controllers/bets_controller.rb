class BetsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @bet = Bet.new(bet_params)
    @bet.hand = @game.hands.last
    @bet.user = current_user
    @bet.save
    redirect_to game_path(@game)
  end

  private

  def bet_params
    params.require(:bet).permit(:amount)
  end
end
