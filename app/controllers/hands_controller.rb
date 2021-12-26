class HandsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    last_button_index = @game.hands.last.users.find_index(@game.hands.last.button)
    if last_button_index && @game.hands.last.users.count - 1 > last_button_index
      button_index = last_button_index + 1
    else
      button_index = 0
    end
    @hand = Hand.new(game: @game, button: @game.users[button_index])
    @hand.save!
    @user_cards = DeckCard.all.sample(@game.users.count * 2)
    index1 = 0
    index2 = 1
    @game.users.each do |user|
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
