# This class represents a movement phantom pawn.
# Used to show to the user where he can move

class @PawnMovementPhantom extends Pawn

  constructor: ( pawn, movement_cost ) ->
    super( pawn.q, pawn.r, pawn.pawn_type, pawn.side, pawn.database_id )
    @movement_cost = movement_cost

  css_id: () ->
    "phantom_pawn_#{@q}_#{@r}"