desc 'Generate map as a json file'
task generate_json_map: :environment do

  @map = AxialGrid.new

  # Load it with
  @map.read_ascii_file_flat_topped_odd( 'data/map.txt' )
  orf_border = JSON.parse( File.open( 'data/orf_border.json', 'r' ).read )

  @map.each do |hex|
    hex.data[ :side ] = 'wulf'
  end

  orf_border.each do |b|
    hex = @map.cget( b['q'], b['r'] )
    data = hex.data[:side] = 'orf'
  end

  File.open( 'data/map.json', 'w' ) do |f|
    f.write( @map.to_json )
  end

end
