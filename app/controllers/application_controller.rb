class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_player
		begin
			@current_player ||= ( (s=session['current_player_id']) && Player.find( s ) )
		rescue
			@current_player = session['current_player_id'] = nil
		end

		# pp @current_player
	end

	private

	def set_board
		@board = Board.find(params[:board_id] || params[:id])

		unless [ @board.wulf_id, @board.orf_id, @board.owner_id ].include?( current_player.id )
			raise "Another player is trying to access someone other's board. CurrentPlayer : #{current_player.inspect}, board : #{@board.inspect}"
		end

		@side = @board.current_side
	end


end
