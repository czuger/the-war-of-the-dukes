# This class contains the pawns functions
#
# @author Cédric ZUGER
#

class @PawnModule

  @PAWNS_TYPES = { 'inf' : 'infantry', 'art' : 'artillery', 'cav' : 'cavalry' }

  # Create a PawnModule object
  #
  # @param map [Map] a reference to the map
  constructor: ( @map ) ->
    @pawn_unicity_list = new PawnsUnicity()

  create_pawn_in_db: (pawn, pawn_type, side) ->
    request = $.post "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns",
      q: pawn.attr( 'q' )
      r: pawn.attr( 'r' )
      pawn_type: pawn_type
      side: side

    request.success (data) ->
      pawn.attr( 'pawn_id', data['pawn_id'] )
      pawn.show()

    request.error (jqXHR, textStatus, errorThrown) ->
      # do something


  update_pawn_position_in_db: (pawn) ->
    $.ajax "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns/#{pawn.attr('pawn_id')}",
      type: 'PATCH'
      dataType: 'html'
      error: (jqXHR, textStatus, errorThrown) ->
        # $('body').append "AJAX Error: #{textStatus}" do something


  put_on_map: (template_pawn_object, q, r, position_on_svg=false) ->
    new_object = @position( template_pawn_object, q, r, true, position_on_svg )
    new_object.attr( 'id', "pawn_#{q}_#{r}")
    new_object.removeClass( 'pawn_template' )
    new_object.addClass('pawn')
    new_object.appendTo( '#board' )
    @pawn_unicity_list.add_hex( q, r )
    new_object


  create_phantom: (pawn, q, r) ->
    new_object = @position( pawn, q, r, true )
    new_object.attr( 'id', "pawn_phantom_#{q}_#{r}")
    new_object.removeClass( 'pawn' )
    new_object.addClass('pawn_phantom')
    new_object.appendTo( '#board' )
    new_object


  # Position a pawn on the map
  #
  # @param pawn_object [Object] the pawn to position
  # @param q [Int] the q position where we want to place the pawn
  # @param r [Int] the r position where we want to place the pawn
  # @param opacity [Float] the opacity of the pawn (0 -> 1)
  # @param clone [Boolean] true if the pawn will be cloned, false if will be moved
  #
  # @return The pawn
  position: ( pawn_object, q, r, clone=false, position_on_svg=false ) ->

    if clone
      new_object = @clone( pawn_object, q, r )
    else
      new_object = pawn_object

    [ x, y ] = @map.get_xy_hex_position( new AxialHex( q, r ) )
    x -= 15
    y -= 16

    unless position_on_svg
      offset = $('#board').offset()
      x += offset.left
      y += offset.top

    new_object.css('top', y )
    new_object.css('left', x )

    new_object


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