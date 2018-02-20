# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null

put_pawn_on_map = ( pawn, q, r, pawn_id ) ->

  new_object = map.pawn_module.put_on_map( pawn, q, r )
  new_object.attr( 'pawn_id', pawn_id )

  new_object.click (event) ->
    on_pawn_click(event, $(this))


load = () ->
  map = new Map()

  $('#board').click () ->
    selected_radio = $('input[name=unit_type]:checked', '#pawn_type_selection').val()

#    console.log( selected_radio )
#
#      pawn_template_id = "##{pawn[3]}_#{PawnModule.PAWNS_TYPES[pawn[2]]}_1"
#      put_pawn_on_map( $(pawn_template_id), pawn[0], pawn[1], pawn[4] )
#      pawn_unicity_list.add_hex( pawn[0], pawn[1] )
#

$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/play/ )
    load()