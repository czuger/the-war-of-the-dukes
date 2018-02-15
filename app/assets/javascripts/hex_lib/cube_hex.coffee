# This class represents an hexagon stored in a cube coordinate system.
#
# Please read http://www.redblobgames.com/grids/hexagons/#coordinates
# to understand what a cube coordinates system is
# The cube class is only for computation.
# It is not intended to be used directly in your program.
#
# @attr_reader [Integer] x the x coordinate of the cube representation of the hexagon
# @attr_reader [Integer] y the y coordinate of the cube representation of the hexagon
# @attr_reader [Integer] z the z coordinate of the cube representation of the hexagon
#
class @CubeHex extends BaseHex

  # Create an hexagon object
  #
  # @param x [Integer] x coordinate
  # @param y [Integer] y coordinate
  # @param z [Integer] z coordinate
  #
  constructor: ( @x, @y, @z, color ) ->
    super( color )

  # Transform a cube represented hexagon to an Hexagon::Axial represented hexagon
  #
  # @return [AxialHex] a new AxialHex object
  #
  to_axial: ->
    new AxialHex(@x, @z, @color)