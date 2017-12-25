# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = 1

load = () ->
  ag = new AxialGrid( 24 )
  ag.from_json( $('#map').val() )

  $('#board').mousemove (event) ->
#    console.log( event.pageX, event.pageY )

    o = $('#board').offset()
    nx = event.pageX - o.left - ag.hex_ray
    ny = event.pageY - o.top - ag.hex_ray
    hex = ag.pixel_to_hex_flat_topped( nx, ny )

    if hex
      color = hex.color
      hex_info = "color = #{color}, x = #{event.pageX}, y = #{event.pageY}, nx = #{nx}, ny = #{ny}, q = #{hex.q}, r = #{hex.r}"
    else
      hex_info = "x = #{event.pageX}, y = #{event.pageY}, nx = #{nx}, ny = #{ny}"

    $('#hex_info').css('top',event.pageY-20)
    $('#hex_info').css('left',event.pageX+30)
    $('#hex_info').show()
    $('#hex_info').html(hex_info)

#$(window).load ->
#  load()

$(document).on( 'turbolinks:load', load )