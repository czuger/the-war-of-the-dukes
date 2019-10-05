module MapHandler

  def set_map
    @json_movement_graph = JSON.parse( File.open( 'data/movement_graph.json' ).read )
    @json_map = JSON.parse( File.open( 'data/map.json' ).read )
  end

end