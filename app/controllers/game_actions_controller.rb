class GameActionsController < ApplicationController

	before_action :set_board

	# The main screen, show the map for action
	def show
	end

	# This action is used to finish the turn
	def phase_finished
		if @board.current_side == Board::ORF
			Board.transaction do
				@board.current_side = Board::WULF
				@board.save!
			end
		else
			Board.transaction do
				@board.current_side = Board::ORF

				@board.pawns.where( pawn_type: :art ).or( Pawn.where( pawn_type: :inf ) ).update_all( remaining_movement: 3 )
				@board.pawns.where( pawn_type: :cav ).update_all( remaining_movement: 6 )

				@board.turn += 1
				@board.save!
			end
		end

		redirect_to boards_path
	end

end
