# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

# An object to store all board related information
root.board = null

# A phantom pawns DB
root.phantom_pawn_db = {}

root.combat_engine = null

opposite_side = { 'orf': 'wulf', 'wulf': 'orf' }

#on_cant_move = (event, jquery_object) ->
#  message = 'Ce pion a déjà bougé ce tour ci'
#  $('#pawn_info').html(message)

on_can_move = (jquery_object) ->

  $('#pawn_info').html('')
  $('.pawn_phantom').remove()

  pawns_on_map = root.board.pawns_on_map
  terrain_map = root.board.terrain_map

  pawn = pawns_on_map.get(jquery_object.attr('id'))

  controlled_hexes = pawns_on_map.controlled_hexes( terrain_map, opposite_side[ pawn.side ] )
#  console.log( controlled_hexes )

  [results, results_costs] = DijkstraMovements.compute_movements( terrain_map, pawns_on_map, pawn, controlled_hexes )
#  console.log( results )
#  console.log( results_costs )
  last_selected_pawn = pawn

  for key in results
    [q, r] = AxialHex.parse_hex_key( key )

    phantom_pawn = new PawnMovementPhantom( pawn, results_costs[key] )
    phantom_pawn.reposition( parseInt(q), parseInt(r) )
    phantom_pawn.show_on_map( pawns_on_map, pawn.css_id() )
    root.phantom_pawn_db[phantom_pawn.css_id()] = phantom_pawn

  manage_movement()
  null

manage_movement = () ->
  $('.pawn_phantom').click ->

    pawns_on_map = root.board.pawns_on_map

    phantom_pawn_id = $(this).attr('id')
    phantom_pawn = root.phantom_pawn_db[phantom_pawn_id]

    last_selected_pawn_id = phantom_pawn.origin_pawn_id
    new_q = phantom_pawn.q
    new_r = phantom_pawn.r

    old_pawn = pawns_on_map.get(last_selected_pawn_id)
    new_pawn = old_pawn.shallow_clone()
    new_pawn.reposition( new_q, new_r )
    new_pawn.set_remaining_movement( phantom_pawn.remaining_movement )

    new_pawn.db_update(
      (data) ->
        pawns_on_map.clear( old_pawn )
        $('#'+last_selected_pawn_id).remove()

        pawns_on_map.set( new_pawn )
        pawns_on_map.place_on_screen_map(new_pawn)

        $('.pawn_phantom').remove()
        root.phantom_pawn_db = {}

        new_pawn.get_jquery_object().click (event) ->
          on_can_move(event, $(this))

#        new_pawn.get_jquery_object().click (event) ->
#          on_pawn_click(event, $(this))
    )


set_movement = () ->

  side = root.board.side

  $(".#{side}").unbind()

  $(".#{side}").click ->
    on_can_move($(this))

load = ( board ) ->
  root.board = board
  pawns_on_map = board.pawns_on_map

  root.combat_engine = new CombatEngine( board )
  root.combat_engine.combat_on( root.combat_engine )

  $('input[type=radio][name=action]').change () ->
    switch $(this).val()
      when 'move'
        set_movement()
      when 'combat'
        root.combat_engine.combat_on( root.combat_engine )
    return




$ ->
  if window.location.pathname.match( /boards\/\d+\/movement/ )

    board_id_regex = RegExp('\\d+');
    board_id = board_id_regex.exec( window.location.pathname )[0]

    Board.load_map( load, { board_id: board_id, movement: true } )