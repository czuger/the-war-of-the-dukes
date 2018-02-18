require 'rhex'
require 'pp'

map = AxialGrid.new
graph = {}
MAX_MOVEMENT = 99

movement_table = {
  c: 0.5, p: 1, f: 2, h: 2, b: 1, w: MAX_MOVEMENT
}

# Load it with
map.read_ascii_file_flat_topped_odd( '../data/map.txt' )

rivers = Hash[ JSON.parse( File.open( '../data/rivers.json', 'r' ).read ).map{ |e| [ [ e['q'], e['r'] ], e['c'] ] } ]
roads = Hash[ JSON.parse( File.open( '../data/roads.json', 'r' ).read ).map{ |e| [ [ e['q'], e['r'] ], e['c'] ] } ]

# pp roads

map.each do |hex|
  map.h_surrounding_hexes( hex ).each do |s_hex|
    movement_cost = nil
    if roads.has_key?( [ hex.q, hex.r ] ) && roads.has_key?( [ s_hex.q, s_hex.r ] )
      movement_cost = 0.5
    elsif rivers.has_key?( [ hex.q, hex.r ] ) && roads.has_key?( [ s_hex.q, s_hex.r ] )
      movement_cost = MAX_MOVEMENT
    else
      movement_cost = movement_table[ s_hex.color.downcase ]
    end
    graph[ [ hex.q, hex.r, s_hex.q, s_hex.r ].join( '_' ) ] = movement_cost
  end
end

File.open( '../data/movement_graph.json', 'w' ) do |file|
  file.puts( graph.to_json )
end