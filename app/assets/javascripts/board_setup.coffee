# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null
pawns_count = null

put_pawn_on_map = ( pawn_template, hex_pos, pawn_type, side ) ->

  if pawns_count[pawn_type] < 10
    new_object = map.pawn_module.put_on_map( pawn_template, hex_pos.q, hex_pos.r )
    new_object.hide()
    map.pawn_module.create_pawn_in_db( new_object, pawn_type, side )
    pawns_count[pawn_type] += 1
    $( "#nb_#{pawn_type}" ).html( "#{pawns_count[pawn_type]} / 10" )

load_pawns = () ->

  pawns = JSON.parse( $('#pawns').val() )
  for pawn in pawns
    pawn_template_id = "##{pawn.side}_#{PawnModule.PAWNS_TYPES[pawn.pawn_type]}_1"
    new_object = map.pawn_module.put_on_map( $(pawn_template_id), pawn.q, pawn.r )
    new_object.attr( 'pawn_id', pawn.id )


load = () ->
  map = new Map()
  pawns_count = JSON.parse( $('#pawns_count').val() )
  load_pawns()

  $('#board').click (event) ->
    selected_radio = $('input[name=unit_type]:checked', '#pawn_type_selection').val()

    hex = map.get_current_hex(event)
    pawn_template = $("##{'orf'}_#{PawnModule.PAWNS_TYPES[selected_radio]}_1")
    put_pawn_on_map(pawn_template, hex, selected_radio, 'orf')

$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/setup/ )
    load()