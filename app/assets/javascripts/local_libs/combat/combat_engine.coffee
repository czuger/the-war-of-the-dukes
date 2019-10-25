root = exports ? this

# This class is used to handle combats
class @CombatEngine

  OPPOSED_SIDE: { 'orf': 'wulf', 'wulf': 'orf' }

  constructor: ->
    @side = root.board.side
    @opponent = @OPPOSED_SIDE[@side] if @side

  combat_on:  ->
    console.log( 'Combat on' )

    $(".#{@side}").unbind()
    $(".#{@side}").attr( 'who', 'me' )
    $(".#{@side}").click () ->
      root.combat_engine.side_selected( $(this) )

    $(".#{@opponent}").unbind()
    $(".#{@opponent}").attr( 'who', 'opponent' )
    $(".#{@opponent}").click ->
      root.combat_engine.opponent_selected( $(this) )

    $('#combat').unbind()
    $('#combat').click ->

      attackers = $('.attacker').toArray().map (a) -> root.board.pawns_on_map.get( $(a).attr('id') )
      defender = root.board.pawns_on_map.get( $( $('.defender')[0] ).attr('id') )

      pf = new PawnFight( root.board, attackers, defender )
      pf.resolve_fight()


  # This happens when our opponent is selected
  opponent_selected: ( jquery_pawn ) ->
    if jquery_pawn.hasClass('defender')
      jquery_pawn.removeClass('defender')

      # If we remove the defender pawn, then the combat can't happen
      $('#combat').attr("disabled", 'disabled');

    else
      $( "div[who='opponent']" ).removeClass('defender')
      jquery_pawn.addClass('defender')

      root.movement_engine.clear_phantoms()

    $( "div[who='me']" ).removeClass('attacker')


  # This is what happens when our side is selected
  side_selected: ( jquery_pawn ) ->
    if $('.defender').length > 0

      if @validate_target( jquery_pawn )
        if jquery_pawn.hasClass('attacker')
          jquery_pawn.removeClass('attacker')
        else
          jquery_pawn.addClass('attacker')

      else
        alert( 'Ce pion ne peut pas attaquer la cible' )

      # We switch on or off the combat button regarding the number of attackers.
      if $('.attacker').length > 0
        $('#combat').removeAttr("disabled");
      else
        $('#combat').attr("disabled", 'disabled');

    else
      root.movement_engine.start_movement( jquery_pawn )

  # Private part

  # This method is used to check if a pawn can attack another
  validate_target: ( jquery_pawn ) ->
    pawn = root.board.pawns_on_map.get( jquery_pawn.attr( 'id' ) )
    jquery_defender_pawn = $( $('.defender')[0] )
    defender_pawn = root.board.pawns_on_map.get( jquery_defender_pawn.attr( 'id' ) )

    if pawn.pawn_type == 'art'
      pawn.get_hex().distance( defender_pawn.get_hex() ) <= 2
    else
      DijkstraMovements.target_distance( root.board, pawn, defender_pawn )







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
