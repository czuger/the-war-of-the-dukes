# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

top_layer = null

load_top_layer = () ->

  for hex in JSON.parse( $('#json_top_layer').val() )
    hex = new AxialHex( parseInt(hex['q']), parseInt(hex['r']), hex['c'] )
    root.set_letter( hex )

manage_changes = ( layer ) ->

  root.load_map()
  load_top_layer()

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

    $.post '/edit_map/update_top_layer',
      q: hex.q
      r: hex.r
      color: hex.color
      layer: layer


$(window).load ->
#  console.log( window.location.pathname )
  if window.location.pathname == '/edit_map/edit_top_layer'
    searchParams = new URLSearchParams(window.location.search)
    layer = searchParams.get('layer')
    manage_changes( layer )