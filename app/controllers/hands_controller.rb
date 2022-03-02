class HandsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @active_players = []
    @game.reservations.where(active: true).each do |reservation|
      @active_players << reservation.user
    end

    last_button_index = @active_players.find_index(@game.hands.last.button) if @game.hands.last

    if last_button_index && @active_players.count - 1 > last_button_index
      button_index = last_button_index + 1
    else
      button_index = 0
    end

    if @active_players.count == 2
      small_blind_index = button_index
      if button_index == 0
        big_blind_index = 1
      else
        big_blind_index = 0
      end
    elsif @active_players.count - 2 > button_index
      small_blind_index = button_index + 1
      big_blind_index = button_index + 2
    elsif @active_players.count - 1 > button_index
      small_blind_index = button_index + 1
      big_blind_index = 0
    else
      small_blind_index = 0
      big_blind_index = 1
    end

    if big_blind_index < @active_players.count - 1
      better_index = big_blind_index + 1
    else
      better_index = 0
    end
    @hand = Hand.new(hand_params)
    @hand.game = @game
    @hand.button = @active_players[button_index]
    @hand.small_blind = @active_players[small_blind_index]
    @hand.big_blind = @active_players[big_blind_index]
    @hand.better = @active_players[better_index]
    @hand.pot = 0
    # @hand = Hand.new(hand_params, game: @game, button: @active_players[button_index], small_blind: @active_players[small_blind_index], big_blind: @active_players[big_blind_index], better: @active_players[better_index], pot: 0 )
    # @hand = Hand.new(game: @game, button: @active_players[button_index], small_blind: @active_players[small_blind_index], big_blind: @active_players[big_blind_index], better: @active_players[better_index], pot: 0 )
    @hand.save!
    @sb_bet = Bet.create(amount: @game.sb_amount, hand: @hand, user: @hand.small_blind)
    @hand.pot += @sb_bet.amount
    @hand.save
    @sb_reservation = @game.reservations.where(user: @hand.small_blind)[0]
    @sb_reservation.score -= @game.sb_amount
    @sb_reservation.save
    @bb_reservation = @game.reservations.where(user: @hand.big_blind)[0]
    @bb_reservation.score -= @game.bb_amount
    @bb_reservation.save
    @bb_bet = Bet.create(amount: @game.bb_amount, hand: @hand, user: @hand.big_blind)
    @hand.pot += @bb_bet.amount
    @hand.save
    if @hand.name == "Texas"
      @user_cards = DeckCard.all.sample(@active_players.count * 2)
      index1 = 0
      index2 = 1
      @active_players.each do |user|
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index1])
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index2])
        UserHand.create(hand: @hand, user: user, active: true)
        index1 += 2
        index2 += 2
      end
    elsif @hand.name == "Pineapple"
      @user_cards = DeckCard.all.sample(@active_players.count * 3)
      index1 = 0
      index2 = 1
      index3 = 2
      @active_players.each do |user|
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index1])
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index2])
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index3])
        UserHand.create(hand: @hand, user: user, active: true)
        index1 += 3
        index2 += 3
        index3 += 3
      end
    elsif @hand.name == "Omaha 4"
      @user_cards = DeckCard.all.sample(@active_players.count * 4)
      index1 = 0
      index2 = 1
      index3 = 2
      index4 = 3
      @active_players.each do |user|
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index1])
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index2])
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index3])
        UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index4])
        UserHand.create(hand: @hand, user: user, active: true)
        index1 += 4
        index2 += 4
        index3 += 4
        index4 += 4
      end
    end


    # (hand_params)
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:game_id])
    @hand = @game.hands.last
    @in_hand_players = []
    UserHand.where(hand: @game.hands.last, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    @last_better = @hand.better
    if @in_hand_players.find_index(@last_better) < @in_hand_players.count - 1
      next_better_index = @in_hand_players.find_index(@last_better) + 1
    else
      next_better_index = 0
    end
    if @in_hand_players[next_better_index].bets.where(hand: @hand).last.amount == @hand.bets.last.amount && @in_hand_players[next_better_index] == @hand.button
      next_better_index = 500_000
    end
    @hand.update_attribute(:better, @in_hand_players[next_better_index])
    redirect_to game_path(@game)
  end

  private

  def hand_params
    params.require(:hand).permit(:name)
  end
  # private

  # def hand_params
  #   params.require(:hand).permit(:active)
  # end
end



# determiner au moment de l'initialisation d'une main la turn et la river aussi mais en mettant un "", puis l'updater en appuyant sur la bouton
# peut-être pas nécessaire pcq turn_card et river card == nil ?
