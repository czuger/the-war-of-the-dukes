# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

set_letter = ( terrain_map, hex ) ->
  [ x, y ] = terrain_map.get_xy_hex_position( hex )

  $("#edit_letter_#{hex.q}_#{hex.r}").remove()

  div = $("<div>#{hex.data.color.toUpperCase()}</div>")
  div.css( 'top', y-12 )
  div.css( 'left', x-5 )
  div.addClass( 'edit_terrain_type' )
  div.attr( 'id', "edit_letter_#{hex.q}_#{hex.r}" )
  div.css( 'color', 'red' ) if hex.color == 'r' || hex.color == 'R'
  $('#board').append( div )


clear_letter = ( hex ) ->
  $("#edit_letter_#{hex.q}_#{hex.r}").remove()



set_map_letters = ( terrain_map ) ->
  searchParams = new URLSearchParams(window.location.search)
  color = searchParams.get('color')
  color = color.toUpperCase() if color

  for _, hex of terrain_map.hexes

    if color == hex.data.color.toUpperCase()
      set_letter( terrain_map, hex )


manage_changes = ( board ) ->

  set_map_letters( board.terrain_map )

  $('#board').mousedown (event) ->

    hex = board.terrain_map.get_current_hex(event)

    searchParams = new URLSearchParams(window.location.search)
    color = searchParams.get('color').toUpperCase()

#    console.log( color )
    hex.data.color = color

    set_letter( hex )

#    console.log( hex )

    board.terrain_map.hset( hex )

    $.post '/edit_map/update_hexes',
      q: hex.q
      r: hex.r
      color: hex.data.color


$(window).load ->
#  console.log( window.location.pathname )
  if window.location.pathname == '/edit_map/edit_hexes'
    Board.load_map( manage_changes )