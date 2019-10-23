class BoardsController < ApplicationController
  before_action :set_board, only: [:action, :setup, :update, :phase_finished ]

  include MapHandler

  SIDES = %w( orf wulf )

	# Used by all scripts to read data
	def map_data
		respond_to do |format|
			format.json do
				render plain: get_map_data
			end
		end
	end

	def call_for_retreat



		redirect_to boards_path
	end

  def setup
    @pawns = @board.pawns

		@side = params[:side]

    side_pawns = @board.pawns.where( side: @side )
    @pawns_count = { inf: 0, cav: 0 , art: 0 }
    @pawns_count = side_pawns.map{ |e| e.pawn_type }.each_with_object(@pawns_count) { |word, counts| counts[word.to_sym] += 1 }

    @requested_places_count = {
        orf: { cities: 22, bastions: 3 }, wulf: { cities: 19, bastions: 4 },
    }
  end

  # GET /boards
  # GET /boards.json
  def index
		current_player_id = current_player['id']

		# pp current_player

    @boards = Board.where( orf_id: current_player_id ).or( Board.where( wulf_id: current_player_id ) ).includes( :orf, :wulf, :owner )
  end

  # GET /boards/new
  def new
    @board = Board.new

		@player = Player.find( current_player['id'] )

    # @opponents = Player.where.not( id: @player.id ).all
    @opponents = Player.all
  end

  # POST /boards
  # POST /boards.json
  def create

		# pp create_board_params

		Board.transaction do
			@board = Board.new(build_new_board_hash)

			respond_to do |format|
				if @board.save
					# place_pawns_on_board

					board_auto_place_pawns

					format.html { redirect_to boards_path, notice: 'Board was successfully created.' }
					format.json { render :show, status: :created, location: @board }
				else
					# @opponents = Player.where.not( id: @player.id ).all

					@player = Player.find( current_player['id'] )
					@opponents = Player.all

					format.html { render :new }
					format.json { render json: @board.errors, status: :unprocessable_entity }
				end
			end
		end

  end

  # POST /boards
  # POST /boards.json
  # def update
  #   if @board.update(update_board_params) && @board.send( params[ :board ][ :switch_board_state ] )
  #     @board.save!
  #     head :ok
  #   else
  #     render json: @board.errors, status: :unprocessable_entity
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.

		def build_new_board_hash
			me_id = current_player.id
			opponent_id = params['opponent_id']

			{
				owner_id: current_player.id,
				orf_id: (params['side'] == 'orf') ? me_id : opponent_id,
				wulf_id: (params['side'] == 'wulf') ? me_id : opponent_id,
				turn: 1
			}
		end

		def board_auto_place_pawns

			data_array = JSON.parse(File.open('data/setup.json','r').read)

			# pp data_array

			Board.transaction do
				data_array.each do |pawn|

					p pawn
					@board.pawns.create!( q: pawn['q'], r: pawn['r'], pawn_type: pawn['type'], side: pawn['side'],
																remaining_action: Pawn::actionS[ pawn['type'] ]  )
				end
			end
		end

end
