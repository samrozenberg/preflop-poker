class BetsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @bet = Bet.new(bet_params)
    @bet.hand = @game.hands.last
    @bet.user = current_user
    @bet.save
    @in_hand_players = []
    UserHand.where(hand: @game.hands.last, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    @active_players = []
    @game.reservations.where(active: true).each do |reservation|
      @active_players << reservation.user
    end
    @last_better = @game.hands.last.better
    if @in_hand_players.find_index(@last_better) < @in_hand_players.count - 1
      next_better_index = @in_hand_players.find_index(@last_better) + 1
    else
      next_better_index = 0
    end
    if @in_hand_players[next_better_index].bets.where(hand: @bet.hand).last && @in_hand_players[next_better_index].bets.where(hand: @bet.hand).last.amount == 30
      next_better_index = 500_000
    end
    @game.hands.last.update_attribute(:better, @in_hand_players[next_better_index])
    redirect_to game_path(@game)
  end

  private

  def bet_params
    params.require(:bet).permit(:amount)
  end
end
