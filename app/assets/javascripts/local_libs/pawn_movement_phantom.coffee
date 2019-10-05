# This class represents a movement phantom pawn.
# Used to show to the user where he can move

class @PawnMovementPhantom extends Pawn

  constructor: ( pawn, movement_cost ) ->
    super( pawn.q, pawn.r, pawn.pawn_type, pawn.side, pawn.database_id )

    @origin_pawn_id = pawn.css_id()

    # On river crossing movement is high or infinite
    @movement_cost = movement_cost
    @remaining_movement = pawn.remaining_movement - movement_cost
#    console.log( @remaining_movement )

  css_id: () ->
    "phantom-pawn-#{@side}-#{@pawn_type}-#{@q}-#{@r}"

  show_on_map: (pawns_on_map_object, old_pawn_id) ->

    new_object = $('<div>')
    #    pawn.set_jquery_object(new_object)
    new_object.attr( 'id', @css_id() )
#    new_object.attr( 'old_pawn_id', old_pawn_id )
#    new_object.attr( 'q', @q )
#    new_object.attr( 'r', @r )
#    new_object.attr( 'movement_cost', @movement_cost )
#    new_object.attr( 'remaining_movement', @remaining_movement )
    new_object.addClass('pawn_phantom')
    new_object.addClass( @css_class() )

    #    console.log( pawn.css_class() )

    pawns_on_map_object.position( this, new_object )

    movement_cost_span = $('<span>')
    movement_cost_span.text( @movement_cost )

    #    console.log( movement_cost_span )
    movement_cost_span.addClass('pawn-movement-cost')

    movement_cost_span.appendTo( new_object )

    new_object.appendTo( '#board' )
    new_object