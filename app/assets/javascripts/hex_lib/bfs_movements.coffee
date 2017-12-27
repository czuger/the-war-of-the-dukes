class @BfsMovements

  anti_deep = 0

  # Call with : find( map, movement_graph, [], [ current_hex.q, current_hex.r ], current_hex, n )
  @find: ( map, movement_graph, walkable_positions, current_hex, remaining_movement ) ->

    hexes_to_process = [ current_hex ]

    while hexes_to_process.length > 0

      current_hex = hexes_to_process.pop()

      wp = walkable_positions[ [ current_hex.q, current_hex.r ].join( '_' ) ]
      if wp
        remaining_movement = wp[ 3 ]

      surrounding_hexes = map.surrounding_hexes( current_hex )
#      console.log( surrounding_hexes )
#      console.log( hexes_to_process.length )

      for hex in surrounding_hexes
        movement_cost = movement_graph[ [ current_hex.q, current_hex.r, hex.q, hex.r ].join( '_' ) ]

#        console.log( hex )
        if movement_cost <= remaining_movement
          wp = walkable_positions[ [ hex.q, hex.r ].join( '_' ) ]

#          console.log( wp )

          if not wp or wp[ 0 ] > movement_cost
#            console.log( 'good' )
            walkable_positions[ [ hex.q, hex.r ].join( '_' ) ] = [ hex.q, hex.r, movement_cost, remaining_movement - movement_cost ]
            hexes_to_process.push( hex )

      anti_deep += 1
#      break if anti_deep > 1000

    console.log( 'done' )