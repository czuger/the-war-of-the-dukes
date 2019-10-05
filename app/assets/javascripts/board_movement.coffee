# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

# A map for the terrain
terrain_map = null
# A map for the pawns
pawns_on_map = null

# A phantom pawns DB
root.phantom_pawn_db = {}

side = null
opposite_side = { 'orf': 'wulf', 'wulf': 'orf' }

on_cant_move = (event, jquery_object) ->
  message = 'Ce pion a déjà bougé ce tour ci'
  $('#pawn_info').html(message)

on_can_move = (event, jquery_object) ->

  $('#pawn_info').html('')
  $('.pawn_phantom').remove()

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

load = () ->

  $.getJSON window.location.pathname + '.json', (data) ->

    terrain_map = new Map( data )
    pawns_on_map = new PawnsOnMap( terrain_map )
    pawns_on_map.load_pawns( data )

    side = data.side

    $(".#{side}").each ->
      id = $(this).attr('id')
      movement_class = if pawns_on_map.get(id).has_moved then 'cant_move' else 'can_move'
      $(this).addClass(movement_class)

    $(".can_move").click (event) ->
      on_can_move(event, $(this))

    $(".cant_move").click (event) ->
      on_cant_move(event, $(this))

$ ->
  if window.location.pathname.match( /boards\/\d+\/movement/ )
    load()