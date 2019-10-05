# This class represents the pawns on the map.

# This class manipulate pawn objects
class @PawnsOnMap

  constructor: ( @map ) ->
    @pawns = {}

  # Return a pawn from it's css id
  get: ( css_id ) ->
    @pawns[ css_id ]

  # Return a pawn from it's css id
  get_from_hex: ( hex ) ->
    @get( 'pawn_' + hex.hex_key() )

  # Set a pawn
  set: ( pawn ) ->
    @pawns[ pawn.css_id() ] = pawn

  # Delete a pawn
  clear: ( pawn ) ->
    delete @pawns[ pawn.css_id() ]


# Load the pawns on screen load
  load_pawns: ( loaded_data ) ->
    json_pawns = loaded_data.pawns
    for json_pawn in json_pawns

      pawn = new Pawn( json_pawn.q, json_pawn.r, json_pawn.pawn_type, json_pawn.side, json_pawn.id )
#      pawn.set_has_moved() if json_pawn.has_moved
      pawn.set_remaining_movement( json_pawn.remaining_movement )

#      console.log( pawn )

      new_object = @place_on_screen_map( pawn )
      @pawns[pawn.css_id()] = pawn

    $('#pawns').remove()
    null


  place_on_screen_map: ( pawn, position_on_svg=false) ->
    new_object = $('<div>')
#    pawn.set_jquery_object(new_object)
    new_object.attr( 'id', pawn.css_id() )
    new_object.attr( 'remaining_movement', pawn.remaining_movement )
    new_object.addClass( pawn.css_class() )
    new_object.addClass( 'pawn' )
    new_object.addClass( pawn.side )
    @position( pawn, new_object, position_on_svg )

    movement_remaining_span = $('<span>')
    movement_remaining_span.text( pawn.remaining_movement )
    #    console.log( movement_remaining_span )
    movement_remaining_span.addClass('pawn-remaining-movement')
    movement_remaining_span.appendTo( new_object )

    new_object.appendTo( '#board' )
    new_object



  # Return all the controlled hexes for the given side
  controlled_hexes: (terrain_map, side) ->
    controlled_pawns = _.map(@pawns, (pawn) -> pawn.control_area(terrain_map) if pawn.side == side)
    _.unique( _.flatten( _.compact( controlled_pawns ) ) )


  # Position a pawn on the map
  #
  # @param pawn_object [Object] the pawn to position
  # @param q [Int] the q position where we want to place the pawn
  # @param r [Int] the r position where we want to place the pawn
  # @param opacity [Float] the opacity of the pawn (0 -> 1)
  # @param clone [Boolean] true if the pawn will be cloned, false if will be moved
  position: ( pawn, jquery_object, position_on_svg=false ) ->

#    console.log( pawn )
    [ x, y ] = @map.get_xy_hex_position( pawn.get_hex() )
    x -= 15
    y -= 16

    unless position_on_svg
      offset = $('#board').offset()
      x += offset.left
      y += offset.top

    jquery_object.css('top', y )
    jquery_object.css('left', x )

    null


  build_hex_keys_hash: () ->
    h = {}
    for key, hex of @pawns
      h[ hex.get_hex().hex_key() ] = true
    h
