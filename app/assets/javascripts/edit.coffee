# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = 1

manage_changes = () ->
  ag = new AxialGrid( 25.7 )
  ag.from_json( $('#map').val() )

  $('#board').click (event) ->

    [ hex, _ ] = MapMethods.get_current_hex(ag, event)

    searchParams = new URLSearchParams(window.location.search)
    color = searchParams.get('color')

    console.log( color )
    hex.color = color

    ag.hset( hex )


$(document).on( 'turbolinks:load', manage_changes )