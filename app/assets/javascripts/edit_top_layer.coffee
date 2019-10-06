# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

manage_changes = ( board ) ->

  eme = new EditMapEngine( board )
  eme.load_top_layer()

  $('#board').mousedown (event) ->

    hex = board.terrain_map.get_current_hex(event)

    if hex.data.color == 'R' || hex.data.color == 'B'
      hex.data.color = null
      root.clear_letter( hex )
      root.current_map.hclear( hex )
    else
      hex.data.color = ( if layer == 'orf_border' then 'B' else 'R' )
      root.set_letter( hex )
      root.current_map.hset( hex )

    $.post '/edit_map/update_top_layer',
      q: hex.q
      r: hex.r
      color: hex.data.color
      layer: layer


$ ->
#  console.log( window.location.pathname )
  if window.location.pathname == '/edit_map/edit_top_layer'

    searchParams = new URLSearchParams(window.location.search)
    layer = searchParams.get('layer')

    Board.load_map( manage_changes, { layer: layer } )