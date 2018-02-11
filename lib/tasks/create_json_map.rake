desc 'Generate map as a json file'
task generate_json_map: :environment do

  @map = AxialGrid.new

  # Load it with
  @map.read_ascii_file_flat_topped_odd( 'data/map.txt' )

  File.open( 'data/map.json', 'w' ) do |f|
    f.write( @map.to_json )
  end

end
