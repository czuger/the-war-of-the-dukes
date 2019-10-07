require 'rhex'
require 'pp'

map = AxialGrid.new
graph = {}
MAX_MOVEMENT = 6

$movement_table = {
  c: 0.5, p: 1, f: 2, h: 2, b: 1, w: MAX_MOVEMENT
}

# Load it with
map.read_ascii_file_flat_topped_odd( '../data/map.txt' )

$rivers = Hash[ JSON.parse( File.open( '../data/rivers.json', 'r' ).read ).map{ |e| [ [ e['q'], e['r'] ], e['c'] ] } ]
$roads = Hash[ JSON.parse( File.open( '../data/roads.json', 'r' ).read ).map{ |e| [ [ e['q'], e['r'] ], e['c'] ] } ]

# pp roads
def over_river?( hex, s_hex )
  if hex.q == 30 && hex.r == 1 && s_hex.q == 30 && s_hex.r == 2
    b = true
  end
  ( $roads.has_key?( [ hex.q, hex.r ] ) || hex.color.downcase == :c || hex.color.downcase == :b ) &&
  ( $roads.has_key?( [ s_hex.q, s_hex.r ] ) || s_hex.color.downcase == :c || s_hex.color.downcase == :b )
end

def bastion?( s_hex )
  s_hex.color.downcase == 'b'
end

def river_crossing?( hex, s_hex )
	river_color = $rivers[ [ hex.q, hex.r ] ]
	s_river_color = $rivers[ [ s_hex.q, s_hex.r ] ]

	river_color && s_river_color && ( river_color != s_river_color )
end

# puts map.cget( 30, 1 ).color
# puts $roads.has_key?( [ 30, 2 ] )

map.each do |hex|
  map.h_surrounding_hexes( hex ).each do |s_hex|
    movement_cost = nil
    if over_river?( hex, s_hex )
      movement_cost = bastion?( s_hex ) ? 1 : 0.5
		elsif river_crossing?( hex, s_hex )
      movement_cost = MAX_MOVEMENT
    else
      movement_cost = $movement_table[ s_hex.color.downcase ]
    end
    # puts "#{[ hex.q, hex.r, s_hex.q, s_hex.r ].join( '_' )} = #{over_river?( hex, s_hex )}"
    graph[ [ hex.q, hex.r, s_hex.q, s_hex.r ].join( '_' ) ] = movement_cost
  end
end

File.open( '../data/movement_graph.json', 'w' ) do |file|
  file.write( JSON.pretty_generate( graph ) )
end