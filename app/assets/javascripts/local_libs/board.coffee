# This class represents a pawn on the map.

class @Board

  constructor: () ->
    @board_id = parseInt( $('#board_id').val() )

# Call the server to update a pawn position
  db_update: ( error_callback_function, success_callback_function ) ->
    request = $.ajax "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns/#{@database_id}",
      type: 'PATCH'
      data: "q=#{@q}&r=#{@r}&has_moved=#{@has_moved}"
    @db_call_callbacks(request, error_callback_function, success_callback_function)

  db_create: ( error_callback_function, success_callback_function ) ->
    request = $.post "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns",
      q: @q
      r: @r
      pawn_type: @pawn_type
      side: @side
    @db_call_callbacks(request, error_callback_function, success_callback_function)

  db_delete: ( error_callback_function, success_callback_function ) ->
    request = $.ajax "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns/#{@database_id}",
      type: 'DELETE'
    @db_call_callbacks(request, error_callback_function, success_callback_function)

  db_call_callbacks: (request, error_callback_function, success_callback_function) ->
    request.success (data) -> success_callback_function(data)
    request.error (jqXHR, textStatus, errorThrown) -> error_callback_function(jqXHR, textStatus, errorThrown)
    request