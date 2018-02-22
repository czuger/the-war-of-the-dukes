# This class contains the pawns functions
#
# @author Cédric ZUGER
#

class @PawnModule

  PAWNS_TYPES = { 'inf' : 'infantry', 'art' : 'artillery', 'cav' : 'cavalry' }

  # Create a PawnModule object
  #
  # @param map [Map] a reference to the map
  constructor: ( @map ) ->


  # Load the pawns on screen load
  load_pawns: ( pawns_grid ) ->
    pawns = JSON.parse( $('#pawns').val() )
    for pawn in pawns
      hex = new AxialHex( pawn.q, pawn.r, { side: pawn.side, pawn_type: pawn.pawn_type } )
      new_object = @place_on_screen_map( hex )
      new_object.attr( 'pawn_id', pawn.id )
      new_object.addClass('pawn')
      new_object.addClass(pawn.side)
      pawns_grid.hset( hex )
    null


  update_pawn_position_in_db: (pawn) ->
    $.ajax "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns/#{pawn.attr('pawn_id')}",
      type: 'PATCH'
      dataType: 'html'
      error: (jqXHR, textStatus, errorThrown) ->
        # $('body').append "AJAX Error: #{textStatus}" do something


  place_on_screen_map: ( hex, position_on_svg=false) ->
    new_object = $('<div>')
    new_object.attr( 'id', "pawn_#{hex.q}_#{hex.r}")
    new_object.addClass( @pawn_class( hex ) )
    new_object = @position( new_object, hex.q, hex.r, position_on_svg )
    new_object.appendTo( '#board' )
    new_object


  create_phantom: (hex) ->
    new_object = $('<div>')
    new_object.attr( 'id', "pawn_phantom_#{hex.q}_#{hex.r}")
    new_object.addClass('pawn_phantom')
    new_object.addClass( @pawn_class( hex ) )
    new_object = @position( new_object, hex.q, hex.r )
    new_object.appendTo( '#board' )
    new_object


  pawn_class: (hex ) ->
    "#{hex.data.side}_#{PAWNS_TYPES[hex.data.pawn_type]}_1"


  # Position a pawn on the map
  #
  # @param pawn_object [Object] the pawn to position
  # @param q [Int] the q position where we want to place the pawn
  # @param r [Int] the r position where we want to place the pawn
  # @param opacity [Float] the opacity of the pawn (0 -> 1)
  # @param clone [Boolean] true if the pawn will be cloned, false if will be moved
  position: ( pawn_object, q, r, position_on_svg=false ) ->

    [ x, y ] = @map.get_xy_hex_position( new AxialHex( q, r ) )
    x -= 15
    y -= 16

    unless position_on_svg
      offset = $('#board').offset()
      x += offset.left
      y += offset.top

    pawn_object.css('top', y )
    pawn_object.css('left', x )


  # This method clone a pawn from the pawn library
  #
  # @param pawn_object [Object] the pawn to clone
  # @param q [Int] the q position where we want to clone the pawn
  # @param r [Int] the r position where we want to clone the pawn
  #
  # @return The cloned item
  clone: ( pawn_object, q, r ) ->
    item = pawn_object.clone()
    item.attr( 'id', 'tmp_inf_' + q + '_' + r )
    item.attr( 'q', q )
    item.attr( 'r', r )
    item.appendTo( 'body' )
    item