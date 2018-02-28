# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# A map for the terrain
terrain_map = null
# A map for the pawns
pawns_on_map = null

side = null

# On server communication error method
on_error_put_pawn_on_map = (jqXHR, textStatus, errorThrown) ->
  $('#error_area').html(errorThrown)
  $('#error_area').show().delay(3000).fadeOut(3000);

on_pawn_click = (event, jquery_object) ->

  $('.pawn_phantom').remove()

  pawn = pawns_on_map.get(jquery_object.attr('id'))

  results = DijkstraMovements.compute_movements( terrain_map, pawn, pawns_on_map.build_hex_keys_hash() )
#  console.log( results )
  last_selected_pawn = pawn

  for key in results
    [q, r] = AxialHex.parse_hex_key( key )

    tmp_pawn = pawn.shallow_clone()
    tmp_pawn.reposition( parseInt(q), parseInt(r) )
    pawns_on_map.create_phantom( tmp_pawn, pawn.css_id() )

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

    new_pawn.db_update( on_error_put_pawn_on_map,
      (data) ->
        pawns_on_map.clear( old_pawn )
        $('#'+last_selected_pawn_id).remove()

        pawns_on_map.set( new_pawn )
        pawns_on_map.place_on_screen_map(new_pawn)

        $('.pawn_phantom').remove()

        new_pawn.jquery_object.click (event) ->
          on_pawn_click(event, $(this))
    )

load = () ->
  terrain_map = new Map()
  pawns_on_map = new PawnsOnMap( terrain_map )
  side = $('#side').val()

  pawns_on_map.load_pawns()

  $(".#{side}").click (event) ->
    on_pawn_click(event, $(this))


$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/movement/ )
    load()