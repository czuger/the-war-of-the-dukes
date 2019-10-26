class GameActionRetreatsController < ApplicationController

	before_action :set_board

	def create
		pawns = JSON.parse( params[:pawns] )

		retreating_side = pawns.first['side']

		supposed_board_player_side = ( params['result'] == 'DR' ? Board.opposite_side( retreating_side ) : retreating_side )
		raise "Trying to set retreat on false board : #{current_player.id}, #{@board.inspect}" unless @board.send( "#{supposed_board_player_side}_id" ) == current_player.id

		pawns_db_id = pawns.map{ |e| e['database_id'] }

		raise "Pawns count didn't match #{pawns_db_id.inspect}, #{@board.inspect}" unless @board.pawns.where( id: pawns_db_id ).count == pawns_db_id.count

		@board.transaction do
			@board.pawns.where( retreating: true ).update_all( retreating: false )
			@board.pawns.where( id: pawns_db_id ).update_all( retreating: true )

			@board.retreating_side = retreating_side
			@board.fight_data= params['result_string']

			@board.start_retreat!

			@board.save!
		end

	end

end