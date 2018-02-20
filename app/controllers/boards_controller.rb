class BoardsController < ApplicationController
  before_action :set_board, only: [ :play ]
  before_action :set_player, only: [:index, :new, :create, :play ]

  include MapHandler

  def play
    set_map
    @pawns = @board.pawns.pluck( :q, :r, :pawn_type, :side, :id ).to_json
  end

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all
  end

  # GET /boards/new
  def new
    @board = Board.new
    @opponents = Player.where.not( id: @player.id ).all
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        place_pawns_on_board
        format.html { redirect_to player_boards_path( @player.id ), notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        @opponents = Player.where.not( id: @player.id ).all
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:board_id])
    end

    def set_player
      @player = Player.find(params[:player_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:opponent_id, :turn).merge(
        {
            owner_id: @player.id
        }
      )
    end

    def place_pawns_on_board
      @board.pawns.create!( q: 27, r: 8, pawn_type: 'inf', side: 'orf' )
      @board.pawns.create!( q: 30, r: 1, pawn_type: 'art', side: 'orf' )
      @board.pawns.create!( q: 28, r: 5, pawn_type: 'cav', side: 'orf' )
    end
end
