class @BfsMovements

  # Call with : find( map, movement_graph, [], [ current_hex.q, current_hex.r ], current_hex, n )
  @find: ( map, movement_graph, walkable_positions, processed_hex_positions, current_hex, remaining_movement ) ->

    surrounding_hexes = map.surrounding_hexes( current_hex )

    for hex in surrounding_hexes
      if [ hex.q, hex.r ] not in processed_hex_positions
        movement_cost = movement_graph[ [ current_hex.q, current_hex.r, hex.q, hex.r ] ]

        if movement_cost >= remaining_movement
          to_process_surrounding_hexes << [ hex.q, hex.r ]
          walkable_positions << [ hex.q, hex.r ]
          find( map, movement_graph, walkable_positions, processed_hex_positions, hex, remaining_movement-movement_cost )

        processed_hex_positions << [ hex.q, hex.r ]