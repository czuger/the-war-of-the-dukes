require 'rhex'
require_relative '../config/initializers/rhex_patch'

map = AxialGrid.from_json_file( '../data/map.json' )
orf_border = JSON.parse( File.open( '../data/orf_border.json', 'r' ).read )

map.each do |hex|
  hex.data[ :side ] = 'wulf'
end

orf_border.each do |b|
  # p b
  hex = map.cget( b['q'], b['r'] )
  hex.data[:side] = 'orf'
end

map.to_json_file( '../data/map.json' )

`ruby build_movement_hash.rb`

