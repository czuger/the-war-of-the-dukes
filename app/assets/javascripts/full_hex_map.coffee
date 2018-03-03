# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

terrain_map = null
pawns_on_map = null

print_mouse_info = () ->
  $('#board').mousemove (event) ->

    hex_info = terrain_map.get_current_hex_info(event)

    html = ''
    for info in hex_info
      html += "<div>#{info}</div>"

    $('#hex_info').html(html)

load = () ->
  show_center = ($('#show_centers').val() == 'true')

  terrain_map = new Map()
  pawns_on_map = new PawnsOnMap( terrain_map )
  print_mouse_info()

  for q in [0..31]
    for r in [-9..22]
      if terrain_map.in_border( new AxialHex( q, r ) )
        if show_center
          terrain_map.show_hex_center( q, r )
        else
          pawns_on_map.place_on_screen_map( new Pawn( q, r, 'inf', 'orf' ), true )

  # Required to show svg elements
  $("body").html($("body").html()) if show_center


$ ->
  if window.location.pathname == '/edit_map/full_hex_map'
    load()
