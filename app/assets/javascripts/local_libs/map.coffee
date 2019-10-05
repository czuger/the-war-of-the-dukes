# This class represents the current map
#
# Please read http://www.redblobgames.com/grids/hexagons/#coordinates to understand what an axial coordinates system is.
#
# @author Cédric ZUGER
#

class @Map extends AxialGrid

  # Create a map
  #
  # @param hex_ray [Integer] the size of an hexagon. Please read : http://www.redblobgames.com/grids/hexagons/#basics for information about the size of an hexagon
  constructor: ( map_json_string = null, movement_graph_json_string = null ) ->

    unless map_json_string?
      map_json = $('#map')
      if map_json.length != 0
        map_json_string = map_json.val()
        $('#map').remove()

    super( 26.1 )
    @from_json( map_json_string )

    @movement_graph = new MovementGraph( movement_graph_json_string )



  # Draw a point on the centre of an hex
  #
  # @param q [Int] the q position of the hex
  # @param r [Int] the r position of the hex
  show_hex_center: ( q, r ) ->
    [ x, y ] = @get_xy_hex_position( new AxialHex( q, r ) )
    $('#svg_overmap').append( "<rect x='#{x}' y='#{y}' width='1' height='1' stroke='red' stroke-width='1' />" )
    null


  # This method get the current hex from the pointer on the map
  get_current_hex: (event) ->

#    console.log( @map_hexes )

    o = $('#board').offset()
    @nx = Math.round( event.pageX - o.left - @hex_ray )
    @ny = Math.round( event.pageY - o.top - @hex_ray )

    [ x_decal, y_decal ] = MapDecal.hex_to_xy_decal( @nx, @ny )
    @nx -= x_decal
    @ny -= y_decal

#    console.log( @nx, @ny )
    @pixel_to_hex_flat_topped( @nx, @ny )


  get_current_hex_info: (event) ->
    hex = @get_current_hex(event)

    if hex
      color = hex.color
      [ col, row ] = hex.to_oddq_coords()
      cube = hex.to_cube()
      hex_info = [ "color = #{color}", "x = #{event.pageX}, y = #{event.pageY}", "nx = #{@nx}, ny = #{@ny}",
        "q = #{hex.q}, r = #{hex.r}", "col = #{col}, row = #{row}", "z = #{cube.z}, x = #{cube.x}, y = #{cube.y}" ]
    else
      hex_info = [ "x = #{event.pageX}, y = #{event.pageY}", "nx = #{@nx}, ny = #{@ny}" ]

    hex_info


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

    [ x, y ] = @hex_to_pixel_flat_topped(hex)
    [ x_decal, y_decal ] = MapDecal.hex_to_xy_decal( x, y )
    x += x_decal
    y += y_decal

    [ x, y ]