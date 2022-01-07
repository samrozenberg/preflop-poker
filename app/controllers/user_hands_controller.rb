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
    @game.hands.last.update_attribute(:better, @in_hand_players[next_better_index])
    @userhand.update_attribute(:active, false)
    redirect_to game_path(@game)
  end
end
