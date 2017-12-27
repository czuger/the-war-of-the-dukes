class @BfsMovements

  anti_deep = 0

  # Call with : find( map, movement_graph, [], [ current_hex.q, current_hex.r ], current_hex, n )
  @find: ( map, movement_graph, walkable_positions, current_hex, remaining_movement ) ->

    surrounding_hexes = map.surrounding_hexes( current_hex )

    for hex in surrounding_hexes

      if not walkable_positions[ [ hex.q, hex.r ].join( '_' ) ]
        movement_cost = movement_graph[ [ current_hex.q, current_hex.r, hex.q, hex.r ].join( '_' ) ]

        if movement_cost <= remaining_movement
          walkable_positions[ [ hex.q, hex.r ].join( '_' ) ] = [ hex.q, hex.r ]
          @find( map, movement_graph, walkable_positions, hex, remaining_movement-movement_cost )

        anti_deep += 1
#        break if anti_deep > 500

    walkable_positions