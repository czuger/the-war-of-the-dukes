# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = 1

load = () ->
  ag = new AxialGrid( 24 )
  ag.from_json( $('#map').val() )

  $('#board').mousemove (event) ->
    console.log( event.pageX, event.pageY )
    console.log( ag.pixel_to_hex_flat_topped( event.pageX-10, event.pageY-10 ) )

#$(window).load ->
#  load()

$(document).on( 'turbolinks:load', load )