class BoardsController < ApplicationController
  before_action :set_board, only: []
  before_action :set_player, only: [:index, :new, :create]

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
      @board = Board.find(params[:id])
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
end
