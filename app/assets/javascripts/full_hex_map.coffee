# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

load = () ->
  show_center = ($('#show_centers').val() == 'true')

  map = new Map()

  for q in [0..31]
    for r in [-9..22]
      if map.in_border( new AxialHex( q, r ) )
        if show_center
          map.show_hex_center( q, r )
        else
          map.pawn_module.put_on_map( $('#orf_infantery_1'), q, r, true )

  # Required to show svg elements
  $("body").html($("body").html()) if show_center


$ ->
  if window.location.pathname == '/edit_map/full_hex_map'
    load()
