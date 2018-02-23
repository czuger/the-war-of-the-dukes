# This class represents the pawns on the map.

class @PawnsOnMap

  constructor: ( @map ) ->
    @pawns = {}


  # Load the pawns on screen load
  load_pawns: ( pawns_grid ) ->
    pawns = JSON.parse( $('#pawns').val() )
    for pawn in pawns
      pawn = new Pawn( pawn.q, pawn.r, pawn.pawn_type, pawn.side )
      new_object = @place_on_screen_map( pawn )
      new_object.attr( 'pawn_id', pawn.css_id() )
      new_object.addClass('pawn')
      new_object.addClass(pawn.side)
      @pawns[pawn.css_id()] = pawn
    null


  place_on_screen_map: ( pawn, position_on_svg=false) ->
    new_object = $('<div>')
    new_object.attr( 'id', pawn.css_id() )
    new_object.addClass( pawn.css_class() )
    pawn.set_jquery_object(new_object)
    @position( pawn, position_on_svg )
    new_object.appendTo( '#board' )
    new_object


# Position a pawn on the map
#
# @param pawn_object [Object] the pawn to position
# @param q [Int] the q position where we want to place the pawn
# @param r [Int] the r position where we want to place the pawn
# @param opacity [Float] the opacity of the pawn (0 -> 1)
# @param clone [Boolean] true if the pawn will be cloned, false if will be moved
  position: ( pawn, position_on_svg=false ) ->

    [ x, y ] = @map.get_xy_hex_position( pawn.hex )
    x -= 15
    y -= 16

    unless position_on_svg
      offset = $('#board').offset()
      x += offset.left
      y += offset.top

    pawn.jquery_object.css('top', y )
    pawn.jquery_object.css('left', x )

    null


  build_hex_keys_hash: () ->
    h = {}
    for key, hex of @hexes
      h[ hex.hex_key() ] = true
    h
