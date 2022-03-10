class BetsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @bet = Bet.new(bet_params)
    @current_hand = @game.hands.last
    if current_user.bets.where(hand: @current_hand).last
      @better_last_bet = current_user.bets.where(hand: @current_hand).last.amount
    end
    @bet.hand = @game.hands.last
    @bet.user = current_user
    @bet.save
    @in_hand_players = []
    UserHand.where(hand: @game.hands.last, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    # @active_players = []
    # @game.reservations.where(active: true).each do |reservation|
    #   @active_players << reservation.user
    # end
    @last_better = @game.hands.last.better
    if @in_hand_players.find_index(@last_better) < @in_hand_players.count - 1
      next_better_index = @in_hand_players.find_index(@last_better) + 1
    else
      next_better_index = 0
    end
    if @in_hand_players[next_better_index].bets.where(hand: @bet.hand).last
      if @in_hand_players[next_better_index].bets.where(hand: @bet.hand).last.amount == @game.max_bet_amount || (@in_hand_players[next_better_index].bets.where(hand: @bet.hand).last.amount == @bet.hand.bets.last.amount && @in_hand_players[next_better_index].bets.where(hand: @bet.hand).last.amount != @game.bb_amount)
        next_better_index = 500_000
      end
    end
    @game.hands.last.update_attribute(:better, @in_hand_players[next_better_index])
    @user_reservation = @game.reservations.where(user: @bet.user)[0]
    if current_user.bets.where(hand: @current_hand).count > 1
      @user_reservation.score -= (@bet.amount - @better_last_bet)
      @current_hand.pot += (@bet.amount - @better_last_bet)
    else
      @user_reservation.score -= @bet.amount
      @current_hand.pot += @bet.amount
    end
    @current_hand.save
    @user_reservation.save
    redirect_to game_path(@game)
  end

  private

  def bet_params
    params.require(:bet).permit(:amount)
  end
end
