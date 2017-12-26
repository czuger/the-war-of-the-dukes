# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = 1

load = () ->
  ag = new AxialGrid( 25.7 )
  ag.from_json( $('#map').val() )

  $('#board').mousemove (event) ->

    [ hex, hex_info ] = MapMethods.get_current_hex(ag, event)

    $('#hex_info').css('top',event.pageY-20)
    $('#hex_info').css('left',event.pageX+30)
    $('#hex_info').show()
    $('#hex_info').html(hex_info)

#$(window).load ->
#  load()

$(document).on( 'turbolinks:load', load )