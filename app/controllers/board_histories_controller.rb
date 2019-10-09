class BoardHistoriesController < ApplicationController

	def show
		respond_to do |format|
			format.html {}
			format.json do
				board = Board.find( params[ :id ] )
				render json: board.board_histories.to_json
			end
		end
	end

end
