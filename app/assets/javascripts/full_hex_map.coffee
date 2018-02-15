# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

load = () ->
  console.log( 'ful_hex_map loaded' )

  o = $('#board').offset()
  $('#svg_overmap').css('top', o.top )
  $('#svg_overmap').css('left', o.left )

  map = new Map()

  for q in [0..31]
    for r in [-9..22]
      if map.in_border( new AxialHex( q, r ) )
        map.position_pawn( $('#orf_infantery_1'), q, r, 1, true )

  # Required to show svg elements
  $("body").html($("body").html());

$ ->
  if $('#full_test_map').val() == 'true'
    load()
