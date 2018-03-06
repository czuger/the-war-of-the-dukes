# This class represents a pawn on the map.

class @Board extends DbCalls

  constructor: () ->
    @board_id = parseInt( $('#board_id').val() )


  # Call the server to update the board status
  db_update: ( switch_board_state, fight_data, success_callback_function, error_callback_function ) ->
    request = $.ajax "/players/#{$('#player_id').val()}/boards/#{board_id}",
      type: 'PATCH'
    data: JSON.stringify( board:{ fight_data: fight_data, switch_board_state: switch_board_state } )
    contentType: "application/json; charset=utf-8"
    @db_call_callbacks(request, success_callback_function, error_callback_function)
