# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.eme = null
root.layer = null

manage_changes = ( board ) ->

  root.eme = new EditMapEngine( board )
  root.eme.load_top_layer()

  $('#board').mousedown (event) ->

    hex = board.terrain_map.get_current_hex(event)

    if hex.data.color == 'R' || hex.data.color == 'B'
      hex.data.color = null
      root.eme.clear_letter( hex )
    else
      hex.data.color = ( if root.layer == 'orf_border' then 'B' else 'R' )
      root.eme.set_letter( hex )

    $.post '/edit_map/update_top_layer',
      q: hex.q
      r: hex.r
      color: hex.data.color
      layer: root.layer


$ ->
#  console.log( window.location.pathname )
  if window.location.pathname == '/edit_map/edit_top_layer'

    searchParams = new URLSearchParams(window.location.search)
    root.layer = searchParams.get('layer')

    Board.load_map( manage_changes, { layer: layer } )