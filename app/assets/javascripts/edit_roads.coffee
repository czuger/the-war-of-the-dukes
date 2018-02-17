# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

roads = null

load_roads = () ->

  for hex in JSON.parse( $('#json_roads').val() )
    hex = new AxialHex( parseInt(hex['q']), parseInt(hex['r']), hex['c'] )
    root.set_letter( hex )

manage_changes = () ->

  load_map()
  load_roads()

  $('#board').mousedown (event) ->

    [ hex, _ ] = root.current_map.get_current_hex(event)

    if hex.color == 'R'
      hex.color = null
      root.clear_letter( hex )
      root.current_map.map_hexes.hclear( hex )
    else
      hex.color = 'R'
      root.set_letter( hex )
      root.current_map.map_hexes.hset( hex )

    $.post '/edit_map/update_roads',
      q: hex.q
      r: hex.r
      color: hex.color


$(window).load ->
#  console.log( window.location.pathname )
  if window.location.pathname == '/edit_map/edit_roads'
    manage_changes()