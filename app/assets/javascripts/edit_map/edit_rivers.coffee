# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.eme = null

manage_changes = ( board ) ->

  root.eme = new EditMapEngine( board )
  root.eme.load_top_layer()

  $('#board').mousedown (event) ->

    river_code = $("input[name='river']:checked").val()

    hex = board.terrain_map.get_current_hex(event)

    if hex.data.color == river_code
      hex.data.color = null
      root.eme.clear_letter( hex )
    else
      hex.data.color = river_code
      root.eme.set_letter( hex )

    $.post '/edit_map/update_top_layer',
      q: hex.q
      r: hex.r
      color: hex.data.color
      layer: 'rivers'


$ ->
#  console.log( window.location.pathname )
  if window.location.pathname == '/edit_map/edit_rivers'

    Board.load_map( manage_changes, { layer: 'rivers' } )