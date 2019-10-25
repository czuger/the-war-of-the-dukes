root = exports ? this

# This class represents a pawn on the map.
class @PawnRetreat extends DbCalls

  constructor: ( @result, @pawns, @result_string ) ->

  # Call the server to set_retreat
  set_retreat: ->

    on_success = ->
      document.location.href="/boards"

    console.log(@pawns)

    request = $.post "/boards/#{root.board.board_id}/game_action_retreats",
      result: @result
      pawns: @pawns
      result_string: @result_string

    @db_call_callbacks(request, on_success)