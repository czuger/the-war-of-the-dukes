# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

# An object to store the loaded history
root.board = null
root.current_position = null
root.max_position = null

load = ( board ) ->
  root.board = board

  console.log( root.board )


  root.current_position = root.max_position = board.max_history_iteration

  $('.adv_zed_button').click () ->

    direction = $(this).attr( 'name' )
#    console.log( direction )

    if direction == 'prev'
      root.current_position = Math.max( root.current_position - 1, 0 )
    else
      root.current_position = Math.min( root.current_position + 1, root.max_position )

    new_pawns_positions = root.board.history[ root.current_position ].pawns_positions
    loaded_data = { pawns: new_pawns_positions }

    $('.pawn').remove()

    root.board.pawns_on_map.load_pawns( loaded_data )

$ ->
  if window.location.pathname.match( /board_histories\/\d+/ )

    board_id_regex = RegExp('\\d+');
    board_id = board_id_regex.exec( window.location.pathname )[0]

    Board.load_map( load, { board_id: board_id, history: true } )