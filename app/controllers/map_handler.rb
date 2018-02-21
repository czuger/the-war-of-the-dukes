module MapHandler

  def set_map
    @json_movement_graph = File.open( 'data/movement_graph.json' ).read
    @json_map = File.open( 'data/map.json' ).read
  end

end