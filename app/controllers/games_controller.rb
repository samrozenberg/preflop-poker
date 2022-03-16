class GamesController < ApplicationController
  def index
    @games = Game.all.reverse
    # @poker_url = ["https://worldfinancialreview.com/wp-content/uploads/2021/04/flush-royal-in-poker-player-hand-lucky-winner-stockpack-adobe-stock-scaled-1.jpg", "https://images.theconversation.com/files/213908/original/file-20180409-114076-691a0s.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=900.0&fit=crop", "https://www.mypokercoaching.com/wp-content/uploads/2020/04/playing-poker-for-a-living.jpg", "https://elie.net/static/images/banner/fuller-house-exposing-high-end-poker-cheating-devices.jpg", "https://www.mypokercoaching.com/wp-content/uploads/2020/04/playing-poker-for-a-living.jpg", "https://pnimg.net/w/articles/0/5dd/fc5534810a.jpg", "https://pnimg.net/w/articles/4/59d/4e06f9bdf7.jpg", "https://i.ytimg.com/vi/K4P3DI6cqxo/maxresdefault.jpg", "https://st4.depositphotos.com/13194036/i/600/depositphotos_308141268-stock-photo-handsome-man-smoking-cigar-black.jpg", "https://media.istockphoto.com/photos/man-playing-texas-hold-em-poker-at-casino-picture-id1158580119?k=20&m=1158580119&s=612x612&w=0&h=BBJ1K591BGmiEPzXJ8v9i8O6RpyxcjWN_HJ0j0wtTnY=", "https://thumbs.dreamstime.com/b/random-poker-cards-over-green-background-169032439.jpg", "https://thesalonhost.com/wp-content/uploads/2021/08/1_6NrFpflyvQ3WzklkfBvUgQ-1.jpg", "https://www.filthylimper.com/wp-content/uploads/2017/03/random-poker-thoughts-2.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/US_Navy_090620-N-2798F-033_Sailors_assigned_to_the_aircraft_carrier_USS_Harry_S._Truman_%28CVN_75%29_and_Carrier_Air_Wing_%28CVW%29_3_compete_in_a_Texas_Hold_%27Em_Poker_tournament_aboard_Harry_S._Truman.jpg/800px-thumbnail.jpg", "https://asset.montecarlosbm.com/styles/hero_desktop_wide_responsive/s3/media/orphea/ca_poker_2018_0001_0.jpg.jpeg?itok=HBpEFAG-", "https://casino.giocodigitale.it/it/blog/wp-content/uploads/2020/05/poker-per-principianti-1145x620.jpg", "https://www.ilpost.it/wp-content/uploads/2019/07/poker.jpg", "https://kaxmedia.com/cdn-cgi/image/h=384,w=680/https://objects.kaxmedia.com/auto/o/1870/6ddefbd693.png", "https://media.nature.com/lw800/magazine-assets/d41586-019-02156-9/d41586-019-02156-9_16920180.jpg", "https://yourpokerdealer.com/wp-content/uploads/2019/02/dealer.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiSznKsAL3SurVWi19TXPq7bKsvetUfoW7eQ&usqp=CAU", "https://thebankrollers.com/wp-content/uploads/2014/12/poker.jpg", "https://ccaf-khmer.org/wp-content/uploads/2021/01/2-2.jpg", "https://i.guim.co.uk/img/static/sys-images/Guardian/Pix/pictures/2013/11/26/1385479353669/98ae8297-8cf7-4138-8a44-09f4573625ec-2060x1236.jpeg?width=620&quality=85&auto=format&fit=max&s=ba797a92287c9dee573b76fce7098bc5", "https://store-images.s-microsoft.com/image/apps.32865.13672061214767198.3336fb4c-c283-4579-ad82-96f02585b57c.9e2e868f-e342-4328-af5d-411155672ccb?mode=scale&q=90&h=1080&w=1920", "https://i.insider.com/5f3aa40ee89ebf001f0453d5?width=1200&format=jpeg", "https://fundacionanade.org/wp-content/uploads/2020/08/pokerplayer.jpg"]
    @game = Game.new
  end

  def show
    if user_signed_in?
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
      @game.reservations.where(active: true).order(:created_at).each do |reservation|
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
      @in_hand_players_card_count = 0
      @in_hand_players.each do |player|
        @in_hand_players_card_count += UserCard.where(hand: @current_hand, user: player).count
      end
      if @game.hands[@game.hands.count - 2]
        @last_hand_remainder = @game.hands[@game.hands.count - 2].remainder
      end

      @button_index = @active_players.find_index(@current_hand.button) if @current_hand

      if @current_hand
        if (@active_players.count - 1 - @active_players.find_index(@current_hand.button)) > 0
          @next_button = @active_players[@active_players.find_index(@current_hand.button) + 1]
        else
          @next_button = @active_players[0]
        end
      end


      @pot = 0
      if @game.hands[@game.hands.count - 2] && @game.hands[@game.hands.count - 2].remainder
        @pot += @game.hands[@game.hands.count - 2].remainder
      end
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
          if @hand_last_bet.amount * 2 <= @game.max_bet_amount
            @min_raise = @hand_last_bet.amount * 2
          else
            @min_raise = @game.max_bet_amount
          end
        end
      end
      if @current_hand && @current_hand.flop_cards.count == 3
        @current_winners = []
        @biggest_odd = 0
        @in_hand_players.each do |player|
          if UserHand.where(user: player, hand: @current_hand)[0].odds.to_f > @biggest_odd
            @biggest_odd = UserHand.where(user: player, hand: @current_hand)[0].odds.to_f
            @current_winners.clear
            @current_winners << player
          elsif UserHand.where(user: player, hand: @current_hand)[0].odds.to_f == @biggest_odd
            @current_winners << player
          end
        end
      end
      if @current_hand && @current_hand.flop_cards.count == 3 && (@current_hand.name == "Pineapple" || @current_hand.name == "Sutra")
        @current_user_card_1 = UserCard.where(hand: @current_hand, user: @user)[0]
        @current_user_card_2 = UserCard.where(hand: @current_hand, user: @user)[1]
        @current_user_card_3 = UserCard.where(hand: @current_hand, user: @user)[2]
      end
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.hand_limit = 100000
    @game.save
    redirect_to games_path
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    max_hand_number = @game.hands.count + 10
    @game.update_attribute(:hand_limit, max_hand_number)
    GameChannel.broadcast_to(
      @game,
      @hand
    )
    redirect_to game_path(@game)
  end

  def destroy
    @game = game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :sb_amount, :bb_amount, :max_bet_amount)
  end
end
