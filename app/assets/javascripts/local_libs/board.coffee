# This class is used to build a board
class @Board extends DbCalls

  constructor: ( loaded_data ) ->

    @top_layer = loaded_data.json_top_layer

    @terrain_map = new Map( loaded_data )
    @pawns_on_map = new PawnsOnMap( @terrain_map )

    if loaded_data.pawns
      @pawns_on_map.load_pawns( loaded_data )


  @load_map: ( callback, params ) ->

    params_string = $.param( params )

    # $.getJSON window.location.pathname + '.json', (data) ->
    $.getJSON "/board/map_data.json?#{params_string}", ( data ) ->

      console.log( data )

      callback( new Board( data ) )


#  constructor: () ->
#    @board_id = parseInt( $('#board_id').val() )
#    @player_id = parseInt( $('#player_id').val() )
#
#
#  defender_retreat: ( defender_pawn, success_callback_function ) ->
#    @db_update( 'wulf_retreat_pawn', { q: defender_pawn.q, r: defender_pawn.r }, success_callback_function )
#
#
#  # Call the server to update the board status
#  db_update: ( switch_board_state, fight_data, success_callback_function, error_callback_function ) ->
#    request = $.ajax "/players/#{@player_id}/boards/#{@board_id}",
#      type: 'PATCH'
#      data: JSON.stringify( board:{ fight_data: fight_data, switch_board_state: switch_board_state } )
#      contentType: "application/json; charset=utf-8"
#    @db_call_callbacks(request, success_callback_function, error_callback_function)
