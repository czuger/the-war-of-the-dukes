# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.eme = null

manage_changes = ( board ) ->

  root.eme = new EditMapEngine( board )
  root.eme.set_map_letters()

  $('#board').mousedown (event) ->

    hex = board.terrain_map.get_current_hex(event)

    searchParams = new URLSearchParams(window.location.search)
    color = searchParams.get('color').toUpperCase()

    hex.data.color = color
    root.eme.set_letter( hex )

    $.post '/edit_map/update_hexes',
      q: hex.q
      r: hex.r
      color: hex.data.color


$(window).load ->
#  console.log( window.location.pathname )
  if window.location.pathname == '/edit_map/edit_hexes'
    Board.load_map( manage_changes )