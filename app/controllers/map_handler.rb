module MapHandler

  def set_map
    @map = SquareGridFlatTopped.new

    # Load it with
    @map.read_ascii_file_flat_topped_odd( 'data/map.txt' )

    @json_movement_graph = File.open( 'data/movement_graph.json' ).read
    p @json_movement_graph

    @json_map = @map.to_json
  end

end