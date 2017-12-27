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
  constructor: ( @q, @r, @color, @border ) ->
    super(@color, @border)
