# This class represents the current map
#
# Please read http://www.redblobgames.com/grids/hexagons/#coordinates to understand what an axial coordinates system is.
#
# @author Cédric ZUGER
#

class @Map

  # Create a map
  #
  # @param hex_ray [Integer] the size of an hexagon. Please read : http://www.redblobgames.com/grids/hexagons/#basics for information about the size of an hexagon
  constructor: () ->
    @map_hexes = new AxialGrid( 26.1 )

    map_json = $('#map')
    if map_json.length != 0
      @map_hexes.from_json( map_json.val() )

    movement_graph_json = $('#movement_hash')
    if movement_graph_json.length != 0
      @movement_graph = JSON.parse( movement_graph_json.val() )

#    console.log( @map_hexes )

  position_pawn: ( pawn_object, q, r, opacity=1, clone=false ) ->

    if clone
      new_object = @clone_pawn( pawn_object, q, r )
    else
      new_object = pawn_object

    pos = new AxialHex( q, r )

    [ x, y ] = @map_hexes.hex_to_pixel_flat_topped( pos )

#    $('#svg_overmap').append( "<rect x='#{x}' y='#{y}' width='1' height='1' stroke='black' stroke-width='1' />" )

    #  console.log( "x = ", x, "y = ", y )
    #  console.log( new_object )

    new_object.css('top', y + 15 )
    new_object.css('left', x + @map_x_correction( q, r ) )
    new_object.css( 'opacity', opacity )
#    new_object.show()
    new_object.removeClass( 'pawn-template' )
    new_object.addClass( 'pawn' )


  map_x_correction: (q, r) ->
    correction = 15
    correction -= Math.max( 0, -11+q/1.1 ) if q >= 13
    correction

  clone_pawn: ( pawn_object, q, r ) ->
    item = pawn_object.clone()
    item.attr( 'id', 'tmp_inf_' + q + '_' + r )
    item.attr( 'q', q )
    item.attr( 'r', r )
    item.appendTo( 'body' )
    item

  get_current_hex: (event) ->

#    console.log( @map_hexes )

    o = $('#board').offset()
    nx = Math.round( event.pageX - o.left - @map_hexes.hex_ray )
    ny = Math.round( event.pageY - o.top - @map_hexes.hex_ray )

    #    console.log( nx, ny )
    hex = @map_hexes.pixel_to_hex_flat_topped( nx, ny )

    if hex
      color = hex.color
      [ col, row ] = hex.to_oddq_coords()
      hex_info = [ "color = #{color}", "x = #{event.pageX}, y = #{event.pageY}", "nx = #{nx}, ny = #{ny}", "q = #{hex.q}, r = #{hex.r}", "col = #{col}, row = #{row}" ]
    else
      hex_info = [ "x = #{event.pageX}, y = #{event.pageY}", "nx = #{nx}, ny = #{ny}" ]

    [ hex, hex_info ]

  in_border: (hex) ->
    [ col, row ] = hex.to_oddq_coords()

    return false if col < 0
    return false if row < 0
    return false if row > 22
    return false if row > 21 && col%2 != 0
    return false if col > 22 && ( row >= 2 && row < 6 )
    return false if col > 22 && col%2 == 0 && row ==6
    return false if col == 31 && row == 6

#    console.log( col, row )

    true
