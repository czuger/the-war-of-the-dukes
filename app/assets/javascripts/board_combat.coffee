

# This class is used to handle combats
class @CombatEngine

  OPPOSED_SIDE: { 'orf': 'wulf', 'wulf': 'orf' }

  constructor: ( board ) ->
    @board = board
    @side = board.side
    @opponent = @OPPOSED_SIDE[@side] if @side

  combat_on: ( global_combat_engine ) ->
    console.log( 'Combat on' )

    $(".#{@side}").unbind()
    $(".#{@side}").attr( 'who', 'me' )
    $(".#{@side}").click () ->
      global_combat_engine.side_selected( $(this) )

    $(".#{@opponent}").unbind()
    $(".#{@opponent}").attr( 'who', 'opponent' )
    $(".#{@opponent}").click ->
      global_combat_engine.opponent_selected( $(this) )


  opponent_selected: ( pawn ) ->
    $( "div[who='opponent']" ).removeClass('defender')
    pawn.addClass('defender')


  side_selected: ( jquery_pawn ) ->

    if $('.defender').length > 0

      if @validate_target( jquery_pawn )
        if jquery_pawn.hasClass('attacker')
          jquery_pawn.removeClass('attacker')
        else
          jquery_pawn.addClass('attacker')

    else
      alert( 'Sélectionnez votre cible avant de sélectionner les attaquants' )

  # Private part
  validate_target: ( jquery_pawn ) ->
    pawn = @board.pawns_on_map.get( jquery_pawn.attr( 'id' ) )
#    console.log( pawn )

    jquery_defender_pawn = $( $('.defender')[0] )
#    console.log( jquery_defender_pawn )
    defender_pawn = @board.pawns_on_map.get( jquery_defender_pawn.attr( 'id' ) )
#    console.log( defender_pawn )

    [results, results_costs] = DijkstraMovements.target_distance( @board, pawn, defender_pawn )

    console.log( results, results_costs )







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
