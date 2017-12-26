# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = 1

manage_changes = () ->
  ag = new AxialGrid( 25.7 )
  ag.from_json( $('#map').val() )

  $('#board').mousedown  (event) ->

    [ hex, _ ] = MapMethods.get_current_hex(ag, event)

    searchParams = new URLSearchParams(window.location.search)
    color = searchParams.get('color')

    console.log( color )
    hex.color = color

    console.log( hex )

    ag.hset( hex )

    $.post '/edit/update',
      q: hex.q
      r: hex.r
      color: hex.color


$(window).load ->
  manage_changes()