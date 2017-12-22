# This class represents a grid of hexagons stored in an axial coordinate system.
#
# Please read http://www.redblobgames.com/grids/hexagons/#coordinates to understand what an axial coordinates system is.
#
# @author Cédric ZUGER
#

class @AxialGrid

  # Create an axial hexagon grid
  #
  # @param hex_ray [Integer] the size of an hexagon. Please read : http://www.redblobgames.com/grids/hexagons/#basics for information about the size of an hexagon
  constructor: ( @hex_ray ) ->
    @hexes={}

  # Create an hexagon at a given position (q, r)
  #
  # @param q [Integer] the q coordinate of the hexagon
  # @param r [Integer] the r coordinate of the hexagon
  # @param color [String] a colorstring that can be used by ImageMagic
  # @param border [Boolean] is the hex on the border of the screen (not fully draw)
  # @param data [Unknown] some data associated with the hexagone. Everything you want, it is up to you.
  #
  # @return [AxialHex] an hexagon
  #
  cset: ( q, r, color, border ) ->
    @hexes[ [ q, r ] ] = new AxialHex( q, r, color, border )

  # Insert an hexagon into the grid
  #
  # @param hex [AxialHex] the hexagon you want to add into the grid
  #
  # @return [AxialHex] the hexagon you inserted
  #
  hset: ( hex ) ->
    @hexes[ [ hex.q, hex.r ] ] = hex

  # Return the grid as a json_array object
  #
  # @return [Array] the grid as a hash object
  from_json: ( json_str ) ->
    js = JSON.parse( json_str )
    for je in js
      this.cset( je['q'], je['r'], je['c'], je['b'] )

    console.log( @hexes )
    console.log( @hexes[[0,0]] )