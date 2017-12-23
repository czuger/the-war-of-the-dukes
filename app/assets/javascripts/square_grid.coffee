# This class represents a grid of hexagons stored in an axial coordinate system but manage the conversion to a square representation (what finally you want)
#
# @author Cédric ZUGER
#
class @SquareGrid extends AxialGrid

  # Create an axial hexagon grid
  #
  # @param hex_ray [Integer] the size of an hexagon.
  constructor: ( hex_ray ) ->
    super( hex_ray )

  # Create an hexagon at a given position (col, row)
  #
  # @param col [Integer] the col coordinate of the hexagon
  # @param row [Integer] the row coordinate of the hexagon
  # @param color [String] a colorstring that can be used by ImageMagic
  # @param border [Boolean] is the hex on the border of the screen (not fully draw)
  # @param data [Unknown] some data associated with the hexagone. Everything you want, it is up to you
  #
  # @return [AxialHex] an hexagon
  #
  cset: ( col, row, color, border, data ) ->
    @hset( @even_q_to_axial_hex( col, row, color, border ) )

  even_q_to_axial_hex: ( col, row, color, border ) ->
    # convert odd-r offset to cube
    x = col - (row - (row&1)) / 2
    z = row
    y = -x-z

    tmp_cube = new CubeHex( x, y, z, color, border )
    tmp_cube.to_axial()

  pixel_to_hex_flatt_topped: (x, y) ->
    x -= 24
    y -= 20

    q = x * 2/3 / @hex_ray
    r = (-x / 3 + Math.sqrt(3)/3 * y) / @hex_ray

    console.log( 'checking for q = ' + Math.round( q ) + 'r = ' + Math.round( r ) )
    return @cget( Math.round( q ), Math.round( r ) )