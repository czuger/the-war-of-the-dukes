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
  constructor: ( map_json_string, movement_graph_json_string ) ->

    @map_hexes = new AxialGrid( 26.1 )
    @map_hexes.from_json( map_json_string )

    @movement_graph = JSON.parse( movement_graph_json_string )

  # Position a pawn on the map
  #
  # @param pawn_object [Object] the pawn to position
  # @param q [Int] the q position where we want to place the pawn
  # @param r [Int] the r position where we want to place the pawn
  # @param opacity [Float] the opacity of the pawn (0 -> 1)
  # @param clone [Boolean] true if the pawn will be cloned, false if will be moved
  #
  # @return The pawn
  position_pawn: ( pawn_object, q, r, opacity=1, clone=false ) ->

    if clone
      new_object = @clone_pawn( pawn_object, q, r )
    else
      new_object = pawn_object

    [ x, y ] = @get_xy_hex_position( new AxialHex( q, r ) )
    x -= 15
    y -= 16

    new_object.css('top', y )
    new_object.css('left', x )
    new_object.css( 'opacity', opacity )
    new_object.removeClass( 'pawn_template' )
    new_object.addClass( 'pawn' )
    new_object.appendTo( '#board' )

    new_object

  # Draw a point on the centre of an hex
  #
  # @param q [Int] the q position of the hex
  # @param r [Int] the r position of the hex
  show_hex_center: ( q, r ) ->
    [ x, y ] = @get_xy_hex_position( new AxialHex( q, r ) )
    $('#svg_overmap').append( "<rect x='#{x}' y='#{y}' width='1' height='1' stroke='red' stroke-width='1' />" )
    null

  # This method clone a pawn from the pawn library
  #
  # @param pawn_object [Object] the pawn to clone
  # @param q [Int] the q position where we want to clone the pawn
  # @param r [Int] the r position where we want to clone the pawn
  #
  # @return The cloned item
  clone_pawn: ( pawn_object, q, r ) ->
    item = pawn_object.clone()
    item.attr( 'id', 'tmp_inf_' + q + '_' + r )
    item.attr( 'q', q )
    item.attr( 'r', r )
    item.appendTo( 'body' )
    item

  # This method get the current hex from the pointer on the map
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
      cube = hex.to_cube()
      hex_info = [ "color = #{color}", "x = #{event.pageX}, y = #{event.pageY}", "nx = #{nx}, ny = #{ny}",
        "q = #{hex.q}, r = #{hex.r}", "col = #{col}, row = #{row}", "z = #{cube.z}, x = #{cube.x}, y = #{cube.y}" ]
    else
      hex_info = [ "x = #{event.pageX}, y = #{event.pageY}", "nx = #{nx}, ny = #{ny}" ]

    [ hex, hex_info ]

  # This tells if an hex is within the borders of the map
  #
  # @param hex [AxialHex] the hex to test
  #
  # @return True or false (if the hex is within the borders or not
  in_border: (hex) ->
    [ col, row ] = hex.to_oddq_coords()

    return false if col < 0
    return false if row < 0
    return false if row > 22
    return false if row > 21 && col%2 != 0
    return false if col > 22 && ( row >= 2 && row < 6 )
    return false if col > 22 && col%2 == 0 && row ==6
    return false if col == 31 && row == 6

    true


  # Get the xy position of an hexagon on the grid. Make corrections according to the deformation of the map.
  #
  # @param hex [AxialHex] the hex we want the coords
  #
  # @return an [x, y] array containing the x, y positions
  get_xy_hex_position: (hex) ->

    [ col, row ] = hex.to_oddq_coords()
    [ x, y ] = @map_hexes.hex_to_pixel_flat_topped(hex)
#
#    x += 15
#    y += 15

    xdecal = [[ 18, 5 ], [ 23, 3 ], [ 25, 2 ], [ 27, 3 ], [ 29, 2 ], [ 30, 2 ] ]
    for decal in xdecal
      if col > decal[0]
        x -= decal[1]

    if col < 4
      x += 4

    if row > 12
      y -= 2
      if col > 14
        x -=3

    if row > 15
      y -= 5

    if row > 19
      y -= 2

    if col >= 4 && col <= 8 && row >= 9
      x += 5

    if row >= 17 && col <= 3
      x += 7

    if row >= 19
      if col >= 21
        x -= 5
      if col >= 26
        y -= 5

    [ x, y ]



