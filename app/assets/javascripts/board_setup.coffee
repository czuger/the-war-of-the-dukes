# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null
pawns_count = null
side = null

on_error_put_pawn_on_map = (jqXHR, textStatus, errorThrown) ->
  $('#error_area').html(errorThrown)
  $('#error_area').show().delay(3000).fadeOut(3000);

create_pawn_in_db = ( hex, pawn_html_object, error_callback_function) ->
  request = $.post "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns",
    q: hex.q
    r: hex.r
    pawn_type: hex.data.pawn_type
    side: hex.data.side

  request.success (data) ->
    pawns_count[hex.data.pawn_type] += 1
    $( "#nb_#{hex.data.pawn_type}" ).html( "#{pawns_count[hex.data.pawn_type]} / 10" )
    pawn_html_object.attr( 'pawn_id', data['pawn_id'] )
    pawn_html_object.show()

  request.error (jqXHR, textStatus, errorThrown) -> on_error_put_pawn_on_map(jqXHR, textStatus, errorThrown)

put_pawn_on_map = ( hex ) ->

  if pawns_count[hex.data.pawn_type] < 10
    new_object = map.pawn_module.put_on_map( hex )
    new_object.hide()
    create_pawn_in_db( hex, new_object, on_error_put_pawn_on_map )


load_pawns = () ->

  pawns = JSON.parse( $('#pawns').val() )
  for pawn in pawns
    new_object = map.pawn_module.put_on_map( new AxialHex( pawn.q, pawn.r, { side: side, pawn_type: pawn.pawn_type } ) )
    new_object.attr( 'pawn_id', pawn.id )


load = () ->
  map = new Map()
  pawns_count = JSON.parse( $('#pawns_count').val() )
  side = $('#side').val()

  load_pawns()

  if side
    $('#board').click (event) ->

      hex = map.get_current_hex(event)
      if hex.data.color != 'w' && hex.data.side == side
        hex.data.pawn_type = $('input[name=pawn_type]:checked', '#pawn_type_selection').val()
        hex.data.side = side
        put_pawn_on_map( hex )


$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/setup/ )
    load()