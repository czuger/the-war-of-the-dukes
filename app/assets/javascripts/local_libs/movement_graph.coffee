# This class represents the costs to move between hexes
#
# @author Cédric ZUGER
#

class @MovementGraph

  # Build the movement graph
  constructor: ( loaded_data ) ->

    @movement_graph = loaded_data.json_movement_graph


  # Build the key for the movement graph
  # from and to are AxialHexes
  can_move: ( from, to ) ->
    @cost( from, to ) <= 2


  # Build the key for the movement graph
  # from and to are AxialHexes
  cost: ( from, to ) ->
    @movement_graph[ @movement_key( from, to ) ]


  # Build the key for the movement graph
  # from and to are AxialHexes
  movement_key: ( from, to ) ->
    [ from.hex_key(), to.hex_key() ].join( '_' )