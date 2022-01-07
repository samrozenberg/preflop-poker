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
    @in_hand_players = []
    UserHand.where(hand: @current_hand, active: true).each do |userhand|
      @in_hand_players << userhand.user
    end
    @pot = 0
    @current_hand.bets.each do |bet|
      @pot += bet.amount
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
