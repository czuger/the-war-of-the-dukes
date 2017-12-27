require 'rhex'

map = SquareGridFlatTopped.new
graph = {}

movement_table = {
  c: 0.5, p: 1, f: 2, h: 2, b: 1, r: 0.5
}

# Load it with
map.read_ascii_file_flat_topped_odd( '../data/map.txt' )

map.each do |hex|
  map.h_surrounding_hexes( hex ).each do |s_hex|
    graph[ [ hex.q, hex.r, s_hex.q, s_hex.r ] ] = movement_table[ s_hex.color ]
  end
end

File.open( '../data/movement_graph.json', 'w' ) do |file|
  file.puts( graph.to_json )
end