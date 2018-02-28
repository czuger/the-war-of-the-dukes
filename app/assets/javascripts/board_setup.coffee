# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This map contain the terrain informations
terrain_map = null
# This map contains the pawns informations
pawns_on_map = null
pawns_count = null
side = null

requested_places_count = null

# On server communication error method
on_error_put_pawn_on_map = (jqXHR, textStatus, errorThrown) ->
  $('#error_area').html(errorThrown)
  $('#error_area').show().delay(3000).fadeOut(3000);

check_map_validity = () ->
  cities_count = 0
  bastions_count = 0
  $('.'+side).each (_, jquery_pawn) ->
    pawn = pawns_on_map.get($(jquery_pawn).attr('id'))
    terrain_color = terrain_map.hget(pawn.get_hex()).data.color
    cities_count += 1 if terrain_color == 'c'
    bastions_count += 1 if terrain_color == 'b'

  $('#cities_count_value').html(cities_count)
  $('#bastions_count_value').html(bastions_count)

# Place a pawn on the map
put_pawn_on_map = ( new_pawn ) ->
  new_pawn.pawn_type = $('input[name=pawn_type]:checked', '#pawn_type_selection').val()
  if pawns_count[new_pawn.pawn_type] < 10
    pawns_on_map.place_on_screen_map( new_pawn )
    new_pawn.get_jquery_object().hide()
    new_pawn.db_create(  on_error_put_pawn_on_map,
      (data) ->
        pawns_count[new_pawn.pawn_type] += 1
        $( "#nb_#{new_pawn.pawn_type}" ).html( "#{pawns_count[new_pawn.pawn_type]} / 10" )
        new_pawn.database_id = parseInt(data['pawn_id'])
        pawns_on_map.set( new_pawn )
        new_pawn.get_jquery_object().show()
        check_map_validity()
    )

# Remove a pawn from the map
remove_pawn_from_map = ( pawn_hex ) ->
  pawn_html_object = '#' + pawn_hex.css_id()
  pawn_hex.db_delete( on_error_put_pawn_on_map,
    (data) ->
      pawns_count[pawn_hex.pawn_type] -= 1
      $( "#nb_#{pawn_hex.pawn_type}" ).html( "#{pawns_count[pawn_hex.pawn_type]} / 10" )
      pawn_hex.get_jquery_object().remove()
      pawns_on_map.clear( pawn_hex )
      check_map_validity()
  )

load = () ->
  terrain_map = new Map()
  pawns_on_map = new PawnsOnMap( terrain_map )
  pawns_count = JSON.parse( $('#pawns_count').val() )
  side = $('#side').val()
  requested_places_count = JSON.parse( $('#requested_places_count').val() )

  pawns_on_map.load_pawns( pawns_on_map )
  check_map_validity()

  if side
    $('#board').click (event) ->

#      console.log( pawns_count )
      terrain_hex = terrain_map.get_current_hex(event)
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