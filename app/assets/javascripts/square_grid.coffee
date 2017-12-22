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
    super( col, row, color, border )

