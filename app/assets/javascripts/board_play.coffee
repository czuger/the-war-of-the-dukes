# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# A map for the terrain
terrain_map = null
# A map for the pawns
pawns_on_map = null

movement_graph = null
last_selected_pawn = null

side = null

on_pawn_click = (event, jquery_pawn) ->

  $('.pawn_phantom').remove()

  pawn_hex = pawns_on_map.cget(terrain_hex)

  result = DijkstraMovements.compute_movements( terrain_map, pawn_hex, movements[pawn_hex.data.pawn_type] , pawns_on_map.build_hex_keys_hash() )
  last_selected_pawn = pawn_hex

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

    q = parseInt((this).attr( 'q' ))
    r = parseInt((this).attr( 'r' ))

    pawns_on_map.cclear( q, r )
    pawns_on_map.cset( q, r, last_selected_pawn.data  )

    terrain_map.pawn_module.pawn_unicity_list.move_hex( last_selected_pawn, $(this) )
    pawns_on_map( )

    last_selected_pawn.remove()

    $('.pawn_phantom').remove()

    terrain_map.pawn_module.send_pawn_new_position($(this))

    $(this).click (event) ->
      on_pawn_click(event, $(this))


load = () ->
  terrain_map = new Map()
  pawns_on_map = new PawnsOnMap( terrain_map )
  side = $('#side').val()

  pawns_on_map.load_pawns()

  $(".#{side}").click (event) ->
    on_pawn_click(event, $(this))


$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/play/ )
    load()