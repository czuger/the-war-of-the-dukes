# This class represents a movement phantom pawn.
# Used to show to the user where he can move

class @PawnMovementPhantom extends Pawn

  constructor: ( pawn, movement_cost ) ->
    super( pawn.q, pawn.r, pawn.pawn_type, pawn.side, pawn.database_id )

    # On river crossing movement is heavy or infinite
    @movement_cost = movement_cost
    @remaining_movement = pawn.remaining_movement - movement_cost

    console.log( @remaining_movement )

  css_id: () ->
    "phantom_pawn_#{@q}_#{@r}"