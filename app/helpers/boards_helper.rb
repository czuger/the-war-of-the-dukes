module BoardsHelper

	def current_action_link( board )
		case board.aasm_state
			when 'orf_turn'

				if @current_player.id == board.orf_id
					link_to 'Orf move', board_movement_path( board )
				else
					'Wait for your opponent to move'
				end

			when 'wulf_turn'

				if @current_player.id == board.wulf_id
					link_to 'Wulf move', board_movement_path( board )
				else
					'Wait for your opponent to move'
				end

		end
	end

	def turn_pawn_position
		top = 414
		left = 1255

		top += (455 - 414) * ( @board.turn-1 )
		"top:#{top}px; left:#{left}px"
	end

end
