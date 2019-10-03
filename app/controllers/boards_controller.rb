class BoardsController < ApplicationController
  before_action :set_player
  before_action :set_board, only: [:movement, :setup, :fight, :update ]
  before_action :set_side, only: [:movement, :fight ]

  include MapHandler

  SIDES = %w( orf wulf )

  def setup
    set_map
    @pawns = @board.pawns

		@side = params[:side]

    side_pawns = @board.pawns.where( side: @side )
    @pawns_count = { inf: 0, cav: 0 , art: 0 }
    @pawns_count = side_pawns.map{ |e| e.pawn_type }.each_with_object(@pawns_count) { |word, counts| counts[word.to_sym] += 1 }

    @requested_places_count = {
        orf: { cities: 22, bastions: 3 }, wulf: { cities: 19, bastions: 4 },
    }
  end

  def movement
    set_map
    @pawns = @board.pawns.select( :id, :q, :r, :pawn_type, :side, :has_moved )
    @pawns = @pawns.to_json
  end

  def fight
    set_map
    @pawns = @board.pawns.select( :id, :q, :r, :pawn_type, :side )
    @pawns = @pawns.to_json
    @result_table = File.open( 'data/result_table.json', 'r' ).read
  end

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all
  end

  # GET /boards/new
  def new
    @board = Board.new
    # @opponents = Player.where.not( id: @player.id ).all
    @opponents = Player.all
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(create_board_params)

    respond_to do |format|
      if @board.save
        # place_pawns_on_board
        format.html { redirect_to player_boards_path( @player.id ), notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        @opponents = Player.where.not( id: @player.id ).all
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /boards
  # POST /boards.json
  def update
    if @board.update(update_board_params) && @board.send( params[ :board ][ :switch_board_state ] )
      @board.save!
      head :ok
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:board_id] || params[:id])
    end

    def set_player
      @player = Player.find(params[:player_id])
    end

    def set_side
      if @player.id == @board.owner_id
        @side, @opponent = SIDES
      else
        @side, @opponent = SIDES.reverse
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_board_params
      params.require(:board).permit(:opponent_id).merge(
        {
            owner_id: @player.id
        }
      )
    end

    def update_board_params
      params.require(:board).permit( { fight_data: [ :q, :r ] }, :turn )
    end

end
