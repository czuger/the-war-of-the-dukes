module MapHandler

  def set_map
    @map = SquareGridFlatTopped.new

    # Load it with
    @map.read_ascii_file_flat_topped_odd( 'app/controllers/map.txt' )

    @json_map = @map.to_json
  end

end