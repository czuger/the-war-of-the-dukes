# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null

print_mouse_info = () ->
  $('#board').mousemove (event) ->

    hex_info = map.get_current_hex_info(event)

    html = ''
    for info in hex_info
      html += "<div>#{info}</div>"

    $('#hex_info').html(html)

load = () ->
  show_center = ($('#show_centers').val() == 'true')

  map = new Map()
  print_mouse_info()

  for q in [0..31]
    for r in [-9..22]
      if map.in_border( new AxialHex( q, r ) )
        if show_center
          map.show_hex_center( q, r )
        else
          map.pawn_module.put_on_map( new AxialHex( q, r, { side: 'orf', pawn_type: 'inf' } ), true )

  # Required to show svg elements
  $("body").html($("body").html()) if show_center


$ ->
  if window.location.pathname == '/edit_map/full_hex_map'
    load()
