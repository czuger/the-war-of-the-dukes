# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null

put_pawn_on_map = ( pawn_template, hex_pos, pawn_type, side ) ->

  new_object = map.pawn_module.put_on_map( pawn_template, hex_pos.q, hex_pos.r )
  new_object.hide()

  map.pawn_module.create_pawn_in_db( new_object, pawn_type, side )


load = () ->
  map = new Map()

  $('#board').click (event) ->
    selected_radio = $('input[name=unit_type]:checked', '#pawn_type_selection').val()

    hex = map.get_current_hex(event)
    pawn_template = $("##{'orf'}_#{PawnModule.PAWNS_TYPES[selected_radio]}_1")
    put_pawn_on_map(pawn_template, hex, selected_radio, 'orf')

#    console.log( selected_radio )
#
#      pawn_template_id = "##{pawn[3]}_#{PawnModule.PAWNS_TYPES[pawn[2]]}_1"
#      put_pawn_on_map( $(pawn_template_id), pawn[0], pawn[1], pawn[4] )
#      pawn_unicity_list.add_hex( pawn[0], pawn[1] )
#

$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/play/ )
    load()