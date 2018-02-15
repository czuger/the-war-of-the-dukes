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
    @map_hexes = new AxialGrid( 26 )

    map_json = $('#map')
    if map_json.length != 0
      @map_hexes.from_json( map_json.val() )

    movement_graph_json = $('#movement_hash')
    if movement_graph_json.length != 0
      @movement_graph = JSON.parse( movement_graph_json.val() )

  position_pawn: ( pawn_object, q, r, opacity=1, clone=false ) ->

    if clone
      new_object = @clone_pawn( pawn_object, q, r )
    else
      new_object = pawn_object

    pos = new AxialHex( q, r )

    [ x, y ] = @map_hexes.hex_to_pixel_flat_topped( pos )

    #  console.log( "x = ", x, "y = ", y )
    #  console.log( new_object )

    new_object.css('top', y + 15 )
    new_object.css('left', x + 15 )
    new_object.css( 'opacity', opacity )

  clone_pawn: ( pawn_object, q, r ) ->
    item = pawn_object.clone()
    item.attr( 'id', 'tmp_inf_' + q + '_' + r )
    item.attr( 'q', q )
    item.attr( 'r', r )
    item.appendTo( 'body' )
    item


