class UserHandsController < ApplicationController
  def update
    @game = Game.find(params[:game_id])
    @current_hand = @game.hands.last
    @user = current_user
    @userhand = UserHand.where(hand: @current_hand, user: @user).last
    @in_hand_players = []
    UserHand.where(hand: @current_hand, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    @last_better = @current_hand.better
    if @in_hand_players.find_index(@last_better) < @in_hand_players.count - 1
      next_better_index = @in_hand_players.find_index(@last_better) + 1
    else
      next_better_index = 0
    end
    @userhand.update_attribute(:active, false)
    @current_hand.update_attribute(:better, @in_hand_players[next_better_index])

    if UserHand.where(hand: @current_hand, active: true).count == 1
      next_better_index = 500000
      HandWinner.create(hand: @current_hand, winner: UserHand.where(hand: @current_hand, active: true)[0].user)
      @current_hand.update_attribute(:better, @in_hand_players[next_better_index])

      @hw = UserHand.where(hand: @current_hand, active: true)[0].user
      @hw.hand_won += 1
      @hw.save
      @hw.hand_not_folded += 1
      @hw.save

      total_pot = 0
      @current_hand.users.each do |user|
        if user.bets.where(hand: @current_hand).last
          total_pot += user.bets.where(hand: @current_hand).last.amount
        end
      end

      if @game.hands.order(:created_at)[@game.hands.count - 2] && @game.hands.order(:created_at)[@game.hands.count - 2].remainder
        total_pot += @game.hands.order(:created_at)[@game.hands.count - 2].remainder
      end

      @game.amount_played += total_pot
      @game.save

      winners = []

      winners << UserHand.where(hand: @current_hand, active: true)[0].user

      @game.reservations.where(active: true).each do |reservation|
        resa = @game.reservations.where(user: reservation.user)[0]
        if winners.include?(reservation.user)
          resa.score += total_pot
        else
          resa.score += 1
          resa.save
          resa.score -= 1
        end
        resa.save
      end
    elsif @current_hand.bets.where(user: @in_hand_players[next_better_index]).last && @current_hand.bets.last.amount == @current_hand.bets.where(user: @in_hand_players[next_better_index]).last.amount && UserHand.where(hand: @current_hand, active: true).count > 1 && @in_hand_players[next_better_index].bets.where(hand: @current_hand).last.amount != @game.bb_amount
      next_better_index = 500000
      @current_hand.update_attribute(:better, @in_hand_players[next_better_index])
    end

    GameChannel.broadcast_to(
      @game,
      @hand
    )

    redirect_to game_path(@game)
  end
end
