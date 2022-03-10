class UserHandsController < ApplicationController
  def update
    @game = Game.find(params[:game_id])
    @user = current_user
    @userhand = UserHand.where(hand: @game.hands.last, user: @user).last
    @in_hand_players = []
    UserHand.where(hand: @game.hands.last, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    @last_better = @game.hands.last.better
    if @in_hand_players.find_index(@last_better) < @in_hand_players.count - 1
      next_better_index = @in_hand_players.find_index(@last_better) + 1
    else
      next_better_index = 0
    end
    @userhand.update_attribute(:active, false)
    @game.hands.last.update_attribute(:better, @in_hand_players[next_better_index])

    if UserHand.where(hand: @game.hands.last, active: true).count == 1
      next_better_index = 500000
      HandWinner.create(hand: @game.hands.last, winner: UserHand.where(hand: @game.hands.last, active: true)[0].user)
      @game.hands.last.update_attribute(:better, @in_hand_players[next_better_index])

      total_pot = 0
      @game.hands.last.users.each do |user|
        if user.bets.where(hand: @game.hands.last).last
          total_pot += user.bets.where(hand: @game.hands.last).last.amount
        end
      end

      if @game.hands[@game.hands.count - 2] && @game.hands[@game.hands.count - 2].remainder
        total_pot += @game.hands[@game.hands.count - 2].remainder
      end

      winners = []

      winners << HandWinner.where(hand: @game.hands.last, winner: UserHand.where(hand: @game.hands.last, active: true)[0].user)[0].winner

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
    end

    GameChannel.broadcast_to(
      @game,
      @hand
    )

    redirect_to game_path(@game)
  end
end
