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

    @hand = Hand.new(game: @game, button: @active_players[button_index], small_blind: @active_players[small_blind_index], big_blind: @active_players[big_blind_index] )
    @hand.save!
    @user_cards = DeckCard.all.sample(@active_players.count * 2)
    index1 = 0
    index2 = 1
    @active_players.each do |user|
      UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index1])
      UserCard.create(hand: @hand, user: user, deck_card: @user_cards[index2])
      UserHand.create(hand: @hand, user: user)
      index1 += 2
      index2 += 2
    end
    # (hand_params)
    redirect_to game_path(@game)
  end

  # private

  # def hand_params
  #   params.require(:hand).permit(:active)
  # end
end



# determiner au moment de l'initialisation d'une main la turn et la river aussi mais en mettant un "", puis l'updater en appuyant sur la bouton
# peut-être pas nécessaire pcq turn_card et river card == nil ?
