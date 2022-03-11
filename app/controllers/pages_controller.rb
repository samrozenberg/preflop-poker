class PagesController < ApplicationController
  def home
  end

  def dashboard
    @user = current_user
    @user_revenue = 0
    @user.reservations.each do |reservation|
      if reservation.score
        @user_revenue += reservation.score
      end
    end

    @total_money_played = 0

    Game.all.each do |game|
      game_total_amount_played = 0
      game.hands.each do |hand|
        if hand.pot != nil
          game_total_amount_played += hand.pot
        end
      end
      @total_money_played += game_total_amount_played
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

    @best_hand = nil
    @worst_hand = nil
    @best_hand_win = 0
    @worst_hand_loss = 0

    Hand.all.each do |hand|
      if hand.hand_winners.include?(@user)
        if hand.pot - hand.bets.where(user: @user).last.amount > @best_hand_win
          @best_hand_win = hand.pot - hand.bets.where(user: @user).last.amount
          @best_hand = hand
        end
      else
        if hand.bets.where(user: @user).last && hand.bets.where(user: @user).last.amount > @worst_hand_loss
          @worst_hand_loss = hand.bets.where(user: @user).last.amount
          @worst_hand = hand
        end
      end
    end
  end
end
