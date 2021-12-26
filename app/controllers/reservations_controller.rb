class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new
    # (reservation_params)
    @user = current_user
    @reservation.user = @user
    @game = Game.find(params[:game_id])
    @reservation.game = @game
    @reservation.score = 0
    if @reservation.save!
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    @game = Game.find(params[:game_id])
    redirect_to game_path(@game)
  end



  # private

  # def reservation_params
  #   params.require(:reservation).permit(:start_date, :end_date, :address)
  # end
end
