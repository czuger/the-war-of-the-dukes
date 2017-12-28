require 'rhex'

class DijkstraMovement

  def self.hex_key( hex )
    [ hex.q, hex.r ].join( '_')
  end

  def self.movement_key( from, to )
    [ from.q, from.r, to.q, to.r ].join( '_')
  end

  # Call with : find( map, movement_graph, [], [ current_hex.q, current_hex.r ], current_hex, n )
  def self.find( map, movement_graph, current_hex )

    goal = AxialHex( -1, -1 )

    frontier = PriorityQueue.new()
    frontier.put(start, 0)
    came_from = {}
    cost_so_far = {}
    came_from[start] = nil
    cost_so_far[start] = 0

    while not frontier.empty()
      current = frontier.get()

      break if current == goal

      map.h_surrounding_hexes( current ).each do |n|
        new_cost = cost_so_far[current] + movement_graph[ movement_key( current, n ) ]
        if not cost_so_far[ hex_key( n ) ] or new_cost < cost_so_far[ hex_key( n ) ]
          cost_so_far[ hex_key( n ) ]  = new_cost
          priority = new_cost
          frontier.put( n, priority )
          came_from[ hex_key( n ) ] = current
        end
      end
    end
  end

end