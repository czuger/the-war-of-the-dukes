module MapHandler

	FILES = {
		'roads' => 'data/roads.json', 'rivers' => 'data/rivers.json', 'orf_border' => 'data/orf_border.json'
	}

  def get_map_data

		data = {
			json_map: JSON.parse( File.open( 'data/map.json' ).read )
		}

		if params[:movement]
			@json_movement_graph = JSON.parse( File.open( 'data/movement_graph.json' ).read )
		end

		if @board
			data[:board] = @board.id
			data[:pawns] = @board.pawns.select( :id, :q, :r, :pawn_type, :side, :remaining_movement )
		end

		if @side
			data[:side] = @side
		end

		if @player
			data[:player_id] = @player.id
		end

		top_layer_file = FILES[params[:layer]]

		if File.exist?( top_layer_file )
			File.open( top_layer_file, 'r' ) do |f|
				data[:json_top_layer] = JSON.parse( f.read )
			end
		end

		data
  end

end