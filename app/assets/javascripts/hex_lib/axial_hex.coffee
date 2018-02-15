# -*- encoding : utf-8 -*-

# This class represents an hexagon stored in axial coordinate system.
#
# Please read http://www.redblobgames.com/grids/hexagons/#coordinates
# to understand what an axial coordinates system is

class @AxialHex extends BaseHex

  # Create an hexagon object
  # - +q+ and +r+ are the coordinates in the axial coords system
  # - +color+ : is a color, anything you want.
  # - +border+ is a boolean and mean that the hex is at the border of the map.
  #
  # *Returns* : a new Hex::Axial object.
  constructor: ( @q, @r, @color ) ->
    super(@color)
    if isNaN(@q) || typeof (@q) == 'string'
      throw "q is not a number!"

    if isNaN(@r) || typeof (@r) == 'string'
      throw "q is not a number!"

  to_oddq_coords: () ->
    cube = @to_cube()

    col = cube.x
    row = cube.z + (cube.x - (cube.x&1)) / 2
    [ col, row ]

  to_cube: () ->
    x = @q
    z = @r
    y = -x-z
    return new CubeHex(x, y, z, @color)