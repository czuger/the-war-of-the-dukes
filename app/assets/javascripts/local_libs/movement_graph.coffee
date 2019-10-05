# This class represents the costs to move between hexes
#
# @author Cédric ZUGER
#

class @MovementGraph

  # Build the movement graph
  constructor: (movement_graph_json_string = null) ->

    unless movement_graph_json_string?
      movement_graph_json = $('#movement_hash')
      if movement_graph_json.length != 0
        movement_graph_json_string = movement_graph_json.val()
        $('#movement_hash').remove()

    @movement_graph = JSON.parse( movement_graph_json_string )


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