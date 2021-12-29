class BetsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @bet = Bet.new(bet_params)
    @bet.hand = @game.hands.last
    @bet.user = current_user
    @bet.save
    @active_players = []
    @game.reservations.where(active: true).each do |reservation|
      @active_players << reservation.user
    end
    @last_better = @game.hands.last.better
    if @active_players.find_index(@last_better) < @active_players.count - 1
      next_better_index = @active_players.find_index(@last_better) + 1
    else
      next_better_index = 0
    end
    @game.hands.last.update_attribute(:better, @active_players[next_better_index])
    redirect_to game_path(@game)
  end

  private

  def bet_params
    params.require(:bet).permit(:amount)
  end
end
