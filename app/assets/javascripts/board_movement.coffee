# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# A map for the terrain
terrain_map = null
# A map for the pawns
pawns_on_map = null

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
  console.log( results )
  console.log( results_costs )
  last_selected_pawn = pawn

  for key in results
    [q, r] = AxialHex.parse_hex_key( key )

    tmp_pawn = pawn.shallow_clone()
    tmp_pawn.reposition( parseInt(q), parseInt(r) )

#    console.log( results_costs[key] )
    pawns_on_map.create_phantom( tmp_pawn, pawn.css_id(), results_costs[key] )

  manage_movement()
  null

manage_movement = () ->
  $('.pawn_phantom').click ->

    last_selected_pawn_id = $(this).attr('old_pawn_id')
    new_q = $(this).attr('q')
    new_r = $(this).attr('r')

    old_pawn = pawns_on_map.get(last_selected_pawn_id)
    new_pawn = old_pawn.shallow_clone()
    new_pawn.reposition( new_q, new_r )
    new_pawn.set_has_moved()

    new_pawn.db_update(
      (data) ->
        pawns_on_map.clear( old_pawn )
        $('#'+last_selected_pawn_id).remove()

        pawns_on_map.set( new_pawn )
        pawns_on_map.place_on_screen_map(new_pawn)

        $('.pawn_phantom').remove()

#        new_pawn.get_jquery_object().click (event) ->
#          on_pawn_click(event, $(this))
    )

load = () ->
  terrain_map = new Map()
  pawns_on_map = new PawnsOnMap( terrain_map )
  side = $('#side').val()

  pawns_on_map.load_pawns()

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