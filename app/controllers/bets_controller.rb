class BetsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @bet = Bet.new(bet_params)
    @bet.game = @game
    @bet.user = current_user
    if @bet.save
      redirect_to game_path(@game, anchor: "bet-#{@bet.id}")
    else
      render "games/show"
    end
  end

  private

  def bet_params
    params.require(:bet).permit(:amount)
  end
end
