# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

root.current_map = null

root.set_letter = ( hex ) ->
  [ x, y ] = root.current_map.get_xy_hex_position( hex )

  $("#edit_letter_#{hex.q}_#{hex.r}").remove()

  div = $("<div>#{hex.color.toUpperCase()}</div>")
  div.css( 'top', y-12 )
  div.css( 'left', x-5 )
  div.addClass( 'edit_terrain_type' )
  div.attr( 'id', "edit_letter_#{hex.q}_#{hex.r}" )
  div.css( 'color', 'red' ) if hex.color == 'r' || hex.color == 'R'
  $('#board').append( div )

root.clear_letter = ( hex ) ->
  $("#edit_letter_#{hex.q}_#{hex.r}").remove()

root.load_map = () ->
  root.current_map = new Map()

#  console.log( root.current_map )

  searchParams = new URLSearchParams(window.location.search)
  color = searchParams.get('color')
  color = color.toUpperCase() if color

  for _, hex of root.current_map.map_hexes.hexes

    if color == hex.color.toUpperCase()
      set_letter( hex )

manage_changes = () ->


  $('#board').mousedown (event) ->

    [ hex, _ ] = root.current_map.get_current_hex(event)

    searchParams = new URLSearchParams(window.location.search)
    color = searchParams.get('color').toUpperCase()

    console.log( color )
    hex.color = color

    set_letter( hex )

    console.log( hex )

    root.current_map.map_hexes.hset( hex )

    $.post '/edit_map/update_hexes',
      q: hex.q
      r: hex.r
      color: hex.color


$(window).load ->
#  console.log( window.location.pathname )
  if window.location.pathname == '/edit_map/edit_hexes'
    manage_changes()