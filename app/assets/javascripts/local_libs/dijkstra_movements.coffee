class @DijkstraMovements

  @movement_key: ( from, to ) ->
    [ from.hex_key(), to.hex_key() ].join( '_' )

  @compute_movements: ( map, current_pawn, hex_key_exclusion_hash ) ->
    max_distance = current_pawn.movement()
    frontier = new PriorityQueue()
    frontier.push(current_pawn.get_hex(), 0)
    frontier_history = []
    came_from = {}
    cost_so_far = {}
    came_from[ current_pawn.get_hex().hex_key() ] = null
    cost_so_far[ current_pawn.get_hex().hex_key() ] = 0
    max_iterations = 0

#    console.log( "frontier =", frontier )

    while not frontier.empty()
      current = frontier.pop()
#      console.log( "frontier.pop() =", current )
      frontier_history.push( current.hex_key() ) unless current.hex_key() in frontier_history

#      console.log( "map.h_surrounding_hexes( current ) = ", map.map_hexes.h_surrounding_hexes( current ) )
      for n in map.h_surrounding_hexes( current )

        max_iterations += 1
        if max_iterations > 10000
          console.log( 'movement search break because of too much iterations' )
          return

        if not hex_key_exclusion_hash[ n.hex_key() ]
#        console.log( n )
          new_cost = cost_so_far[ current.hex_key() ] + map.movement_graph[ @movement_key( current, n ) ]

          unless new_cost > max_distance
            if ( not cost_so_far[ n.hex_key() ] ) or new_cost < cost_so_far[ n.hex_key() ]
              cost_so_far[ n.hex_key() ] = new_cost
              priority = new_cost
              frontier.push( n, priority )
              came_from[ n.hex_key() ] = current

#    console.log( frontier_history.sort() )

    frontier_history.shift()
    frontier_history