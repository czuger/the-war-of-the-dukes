# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null
movement_graph = null
last_selected_pawn = null
pawns_on_map = null
side = null

movements = { 'art': 3, 'cav': 6, 'inf': 3 }

on_pawn_click = (event, pawn) ->

  $('.pawn_phantom').remove()

  terrain_hex = map.get_current_hex(event)
  pawn_hex = pawns_on_map.hget(terrain_hex)

  result = DijkstraMovements.compute_movements( map, pawn_hex, movements[pawn_hex.data.pawn_type] , pawns_on_map.build_hex_keys_hash() )
  last_selected_pawn = pawn

  for key in result
    [q, r] = AxialHex.parse_hex_key( key )

    tmp_hex = JSON.parse(JSON.stringify(pawn_hex));
    tmp_hex.q = parseInt(q)
    tmp_hex.r = parseInt(r)

    map.pawn_module.create_phantom( tmp_hex )

#  manage_movement()
  null


manage_movement = () ->
  $('.pawn_phantom').click ->
    $(this).removeClass('pawn_phantom')
    $(this).addClass('pawn')

    map.pawn_module.pawn_unicity_list.move_hex( last_selected_pawn, $(this) )

    last_selected_pawn.remove()

    $('.pawn_phantom').remove()

    map.pawn_module.send_pawn_new_position($(this))

    $(this).click (event) ->
      on_pawn_click(event, $(this))


load = () ->
  map = new Map()
  pawns_on_map = new PawnsOnMap()
  side = $('#side').val()

  map.pawn_module.load_pawns( pawns_on_map )

  $(".#{side}").click (event) ->
    on_pawn_click(event, $(this))


$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/play/ )
    load()