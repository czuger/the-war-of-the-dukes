# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This map contain the terrain informations
map = null
# This map contains the pawns informations
pawns_on_map = null
pawns_count = null
side = null

# On server communication error method
on_error_put_pawn_on_map = (jqXHR, textStatus, errorThrown) ->
  $('#error_area').html(errorThrown)
  $('#error_area').show().delay(3000).fadeOut(3000);

# Place a pawn on the map
put_pawn_on_map = ( new_pawn ) ->
  new_pawn.pawn_type = $('input[name=pawn_type]:checked', '#pawn_type_selection').val()
  if pawns_count[new_pawn.pawn_type] < 10
    pawns_on_map.place_on_screen_map( new_pawn )
    new_pawn.jquery_object.hide()
    new_pawn.db_create(  on_error_put_pawn_on_map,
      (data) ->
        pawns_count[new_pawn.pawn_type] += 1
        $( "#nb_#{new_pawn.pawn_type}" ).html( "#{pawns_count[new_pawn.pawn_type]} / 10" )
        new_pawn.database_id = parseInt(data['pawn_id'])
        pawns_on_map.set( new_pawn )
        new_pawn.jquery_object.show()
    )

# Remove a pawn from the map
remove_pawn_from_map = ( pawn_hex ) ->
  pawn_html_object = '#' + pawn_hex.css_id()
  pawn_hex.db_delete( on_error_put_pawn_on_map,
    (data) ->
      pawns_count[pawn_hex.pawn_type] -= 1
      $( "#nb_#{pawn_hex.pawn_type}" ).html( "#{pawns_count[pawn_hex.pawn_type]} / 10" )
      pawn_hex.jquery_object.remove()
      pawns_on_map.clear( pawn_hex )
  )

load = () ->
  map = new Map()
  pawns_on_map = new PawnsOnMap( map )
  pawns_count = JSON.parse( $('#pawns_count').val() )
  side = $('#side').val()

  pawns_on_map.load_pawns( pawns_on_map )

  if side
    $('#board').click (event) ->

#      console.log( pawns_count )
      terrain_hex = map.get_current_hex(event)
      if terrain_hex.data.color != 'w' && terrain_hex.data.side == side
        new_pawn = new Pawn( terrain_hex.q, terrain_hex.r, null, side)
        pawn_hex = pawns_on_map.get( new_pawn.css_id() )
        if pawn_hex
          remove_pawn_from_map( pawn_hex )
        else
          put_pawn_on_map( new_pawn )


$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/setup/ )
    load()