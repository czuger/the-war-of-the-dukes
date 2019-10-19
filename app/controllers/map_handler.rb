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

		# Reading base map data
		data = {
			# json_map: JSON.parse( File.open( 'data/map.json' ).read )
			json_map: []
		}

		# Reading movement graph
		if params[:movement]
			# data[:json_movement_graph] = JSON.parse( File.open( 'data/movement_graph.json' ).read )
			data[:json_movement_graph] = []
			replace_movement = true
		end

		# Reading current pawns position
		if params[:board_id]
			set_board
			set_side
			data[:pawns] = @board.pawns.select( :id, :q, :r, :pawn_type, :side, :remaining_movement )
			data[:side] = @side

			# Reading history (in case we asked for history)
			if params[:history]
				data[:history] = @board.board_histories
				data[:max_history_iteration] = data[:history].maximum( :movements_increments )
			end
		end

		# Reading top layers files (in case we are in the edit controller)
		top_layer_file = FILES[params[:layer]]
		if top_layer_file && File.exist?( top_layer_file )
			File.open( top_layer_file, 'r' ) do |f|
				data[:json_top_layer] = JSON.parse( f.read )
			end
		end

		data = data.to_json

		map_data = File.open( 'data/map.json' ).read
		data.gsub!( '"json_map":[]', "\"json_map\":#{map_data}" )

		if replace_movement
			movement_data = File.open( 'data/movement_graph.json' ).read
			data.gsub!( '"json_movement_graph":[]', "\"json_movement_graph\":#{movement_data}" )
		end

		data
  end

end