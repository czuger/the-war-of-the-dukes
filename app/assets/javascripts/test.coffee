# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


load = () ->
  ag = new SquareGrid( 16 )
  ag.from_json( $('#map').val() )

#$(window).load ->
#  load()

$(document).on( 'turbolinks:load', load )