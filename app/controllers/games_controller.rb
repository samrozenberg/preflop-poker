class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @bet = Bet.new
    @hand = Hand.new
    @flop_card = FlopCard.new
    @turn_card = TurnCard.new
    @river_card = RiverCard.new
    @user = current_user
    @cards = DeckCard.all
    @reservation = Reservation.new
    @reservations = Reservation.all
    @active_players = []
    @game.reservations.where(active: true).each do |reservation|
      @active_players << reservation.user
    end
    @current_hand = @game.hands.last
    @current_hand_winners = []
    HandWinner.where(hand: @current_hand).each do |hand_winner|
      @current_hand_winners << hand_winner.winner.pseudo
    end
    @in_hand_players = []
    UserHand.where(hand: @current_hand, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    @pot = 0
    if @current_hand
      @current_hand.users.each do |user|
        if user.bets.where(hand: @current_hand).last
          @pot += user.bets.where(hand: @current_hand).last.amount
        end
      end
      @hand_last_bet = @current_hand.bets.last
      @user_last_bet = @user.bets.where(hand: @current_hand).last
      @current_player_user_hand = UserHand.where(hand: @current_hand, user: @user)
      if @hand_last_bet
        if @hand_last_bet.amount * 2 <= 30
          @min_raise = @hand_last_bet.amount * 2
        else
          @min_raise = 30
        end
      end
    end
    @used_cards = []
    @current_hand.user_cards.each do |user_card|
      @used_cards << user_card.deck_card
    end
    @current_hand.flop_cards.each do |flop_card|
      @used_cards << flop_card.deck_card
    end
    @current_hand.turn_cards.each do |turn_card|
      @used_cards << turn_card.deck_card
    end
    @available_cards = DeckCard.all - @used_cards

    if @current_hand.flop_cards.count == 0
      @combinations = @available_cards.combination(5).to_a.sample(1000)
    elsif @current_hand.flop_cards.count == 3 && @current_hand.turn_cards.count == 0
      @combinations = @available_cards.combination(2).to_a.sample(200)
    elsif @current_hand.turn_cards.count == 1 && @current_hand.river_cards.count == 0
      @combinations = @available_cards.combination(1).to_a
    end

    @players_card_combinations = []
    @in_hand_players.each do |player|
      instance_variable_set("@#{player.pseudo}_cards", [])
      UserCard.where(hand: @current_hand, user: player).each do |card|
        instance_variable_get("@#{player.pseudo}_cards") << card.deck_card.code
      end
      @players_card_combinations << instance_variable_get("@#{player.pseudo}_cards")
    end

    @winners = []

    if @current_hand.river_cards.count == 0 && @current_hand
      @combinations.each do |combination|
        winning_simulation = PokerHand.new("")
        winning_player = @in_hand_players[0]
        @in_hand_players.each do |player|
          instance_variable_set("@#{player.pseudo}_pokerhand", PokerHand.new(instance_variable_get("@#{player.pseudo}_cards")))
          combination.each do |card|
            instance_variable_get("@#{player.pseudo}_pokerhand") << card.code
          end
          if instance_variable_get("@#{player.pseudo}_pokerhand") > winning_simulation
            winning_simulation = instance_variable_get("@#{player.pseudo}_pokerhand")
            winning_player = player
          end
        end
        @winners << winning_player
      end
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.save
    redirect_to game_path(@game)
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update(game_params)
    redirect_to game_path(@game)
  end

  def destroy
    @game = game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
