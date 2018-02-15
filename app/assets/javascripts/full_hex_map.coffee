# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

load = () ->
  console.log( 'ful_hex_map loaded' )
  map = new Map()

  for q in [1..20]
    for r in [1..20]
      map.position_pawn( $('#orf_infantery_1'), q, r, 1, true )

$ ->
  if $('#full_test_map').val() == 'true'
    load()