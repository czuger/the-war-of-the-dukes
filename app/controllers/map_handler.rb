module MapHandler

	FILES = {
		'roads' => 'data/roads.json', 'rivers' => 'data/rivers.json', 'orf_border' => 'data/orf_border.json'
	}

	def set_map_data
		top_layer_file = FILES[params[:layer]]

		map = AxialGrid.from_json_file( top_layer_file )
		# puts params[:q].inspect

		if params[:color] == ''
			map.cclear( params[:q].to_i, params[:r].to_i )
		else
			map.cset( params[:q].to_i, params[:r].to_i, data:{ color: params[:color] } )
		end

		map.to_json_file( top_layer_file )
	end

  def get_map_data

		data = {
			json_map: JSON.parse( File.open( 'data/map.json' ).read )
		}

		if params[:movement]
			data[:json_movement_graph] = JSON.parse( File.open( 'data/movement_graph.json' ).read )
		end

		if params[:board_id]
			set_board
			set_side
			data[:board] = @board.id
			data[:pawns] = @board.pawns.select( :id, :q, :r, :pawn_type, :side, :remaining_movement )
			data[:side] = @side
		end

		if @player
			data[:player_id] = @player.id
		end

		top_layer_file = FILES[params[:layer]]

		if top_layer_file && File.exist?( top_layer_file )
			File.open( top_layer_file, 'r' ) do |f|
				data[:json_top_layer] = JSON.parse( f.read )
			end
		end

		data
  end

end