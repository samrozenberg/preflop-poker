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
