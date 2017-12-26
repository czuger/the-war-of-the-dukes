module MapHandler

  def set_map
    g = SquareGridFlatTopped.new

    # Load it with
    g.read_ascii_file_flat_topped_odd( 'app/controllers/map' )

    @map = g.to_json
  end

end