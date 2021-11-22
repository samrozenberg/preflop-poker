class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @bet = Bet.new
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
