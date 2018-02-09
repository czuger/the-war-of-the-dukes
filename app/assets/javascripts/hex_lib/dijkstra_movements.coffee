class @DijkstraMovements

  @hex_key: ( hex ) ->
    [ hex.q, hex.r ].join( '_')

  @movement_key: ( from, to ) ->
    [ from.q, from.r, to.q, to.r ].join( '_')

  @calc: ( map, movement_graph, current_hex, max_distance ) ->
    frontier = new PriorityQueue()
    frontier.push(current_hex, 0)
    frontier_history = []
    came_from = {}
    cost_so_far = {}
    came_from[ @hex_key(current_hex) ] = null
    cost_so_far[ @hex_key(current_hex) ] = 0

    console.log( "frontier =", frontier )

    while not frontier.empty()
      current = frontier.pop()
      console.log( "frontier.pop() =", current )
      frontier_history << @hex_key( current ) unless frontier_history.include?( @hex_key( current ) )

      for n in map.h_surrounding_hexes( current )
        console.log( n )
        new_cost = cost_so_far[ @hex_key(current) ] + movement_graph[ movement_key( current, n ) ]

        if new_cost > max_distance
          next

        if ( not cost_so_far[ @hex_key( n ) ] ) or new_cost < cost_so_far[ @hex_key( n ) ]
          cost_so_far[ @hex_key( n ) ] = new_cost
          priority = new_cost
          frontier.push( n, priority )
          came_from[ @hex_key( n ) ] = current

    console.log( frontier_history )

    frontier_history