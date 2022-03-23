class PagesController < ApplicationController
  def home
  end

  def all_hands
    @user = current_user
  end

  def dashboard
    if user_signed_in?
      @user = current_user
      @user_revenue = 0
      @user.reservations.each do |reservation|
        if reservation.score
          @user_revenue += reservation.score
        end
      end

      @total_money_played = 0

      Game.all.each do |game|
        @total_money_played += game.amount_played
      end

      @biggest_score = -20000
      @lowest_score = 20000

      @biggest_winner = nil
      @biggest_loser = nil

      User.all.each do |user|
        user_total_score = 0
        user.reservations.each do |reservation|
          if reservation.score
            user_total_score += reservation.score
          end
        end
        if user_total_score > @biggest_score
          @biggest_score = user_total_score
          @biggest_winner = user
        end
        if user_total_score < @lowest_score
          @lowest_score = user_total_score
          @biggest_loser = user
        end
      end

      @last_hand_winners = []


      if @user.hands.last
        @user.hands.last.hand_winners.each do |handwinner|
          @last_hand_winners << handwinner.winner
        end

        if @last_hand_winners.include?(@user) && @user.hands.last.bets.where(user: @user).last
          @last_hand_win_amount = (@user.hands.last.pot - @user.hands.last.bets.where(user: @user).last.amount) / @last_hand_winners.count
          if @user.hands.last.game.hands[(@user.hands.last.game.hands.find_index(@user.hands.last) - 1)].remainder
            @last_hand_win_amount += @user.hands.last.game.hands[(@user.hands.last.game.hands.find_index(@user.hands.last) - 1)].remainder
          end
        elsif @user.hands.last.bets.where(user: @user).last
          @last_hand_loss_amount = @user.hands.last.bets.where(user: @user).last.amount
        end
      end
    end
  end
end
