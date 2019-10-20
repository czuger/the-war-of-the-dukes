class @DijkstraMovements

  @compute_movements: ( board, current_pawn, controlled_hexes ) ->
    @board = board
    @map = board.terrain_map
    @controlled_hexes_keys = _.object( _.map( controlled_hexes, (hex) -> [ hex.hex_key(), true ] ) )
    @hex_key_exclusion_hash = board.pawns_on_map.build_hex_keys_hash()
    @current_pawn = current_pawn

    @core()

  @target_distance: ( board, current_pawn, dest_pawn ) ->
    @board = board
    @map = board.terrain_map
    @controlled_hexes_keys = []
    @hex_key_exclusion_hash = {}
    @current_pawn = current_pawn
    @dest_pawn = dest_pawn

    @core()


  @core: ->
    console.log( @current_pawn )
    max_distance = @current_pawn.movement()
    frontier = new PriorityQueue()
    frontier.push( @current_pawn.get_hex(), 0 )
    frontier_history = []
    frontier_history_costs = {}
    came_from = {}
    cost_so_far = {}
    came_from[ @current_pawn.get_hex().hex_key() ] = null
    cost_so_far[ @current_pawn.get_hex().hex_key() ] = 0
    max_iterations = 0

    if @dest_pawn
      destination_key = @dest_pawn.get_hex().hex_key()

#    console.log( "frontier =", frontier )

    while not frontier.empty() # && (!current || (current.hex_key() != destination_key))
      current = frontier.pop()
      console.log( "frontier.pop() =", current )

      console.log( current.hex_key(), destination_key )
#      break if

      frontier_history.push( current.hex_key() ) unless current.hex_key() in frontier_history

#      console.log( "map.h_surrounding_hexes( current ) = ", map.map_hexes.h_surrounding_hexes( current ) )
      for n in @map.h_surrounding_hexes( current )

        max_iterations += 1
        if max_iterations > 10000
          console.log( 'movement search break because of too much iterations' )
          return

        if not @hex_key_exclusion_hash[ n.hex_key() ]

          current_cost = frontier_history_costs[ current.hex_key() ]
          current_cost = Infinity unless current_cost

          frontier_history_costs[ current.hex_key() ] = Math.min( cost_so_far[ current.hex_key() ], current_cost )

          if n.hex_key() == '19_-2'
            console.log( 'Current hex', current )
            console.log( 'Surrounding hex', n )
            console.log( 'current cost', current_cost )
            console.log( 'movement_graph cost', @map.movement_graph.cost( current, n ) )

          new_cost = cost_so_far[ current.hex_key() ] + @map.movement_graph.cost( current, n )

          unless new_cost > max_distance
            if ( not cost_so_far[ n.hex_key() ] ) or new_cost < cost_so_far[ n.hex_key() ]

              # We can enter the control area, but then we are stuck in it
              new_cost +=  @control_area_cost( n )

              cost_so_far[ n.hex_key() ] = new_cost
              priority = new_cost
              frontier.push( n, priority )
              came_from[ n.hex_key() ] = current

#    console.log( frontier_history.sort() )

    frontier_history.shift()
    [frontier_history, frontier_history_costs]

  @control_area_cost: ( dest_hex ) ->
    return 15 if @controlled_hexes_keys[ dest_hex.hex_key() ]
    0
