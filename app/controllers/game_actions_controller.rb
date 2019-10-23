class GameActionsController < ApplicationController

	before_action :set_board

	# The main screen, show the map for action
	def show
	end

	# This action is used to finish the turn
	def phase_finished
		if @board.aasm_state == 'orf_turn'
			Board.transaction do
				@board.next_to_wulf_turn!
			end
		else
			Board.transaction do
				@board.next_to_orf_turn!

				@board.pawns.where( pawn_type: :art ).or( Pawn.where( pawn_type: :inf ) ).update_all( remaining_action: 3 )
				@board.pawns.where( pawn_type: :cav ).update_all( remaining_action: 6 )

				@board.turn += 1
				@board.save!
			end
		end

		redirect_to board_action_path( @board )
	end

	private

	def set_board
		@board = Board.find(params[:board_id] )

		unless [ @board.wulf_id, @board.orf_id, @board.owner_id ].include?( current_player.id )
			raise "Another player is trying to access someone other's board. CurrentPlayer : #{current_player.inspect}, board : #{@board.inspect}"
		end
	end

end
