
class @EditMapEngine

  constructor: ( board ) ->
    @terrain_map = board.terrain_map
    @top_layer = board.top_layer

  set_letter: ( hex, graphical_only = false ) ->
    @terrain_map.hset( hex ) unless graphical_only

    [ x, y ] = @terrain_map.get_xy_hex_position( hex )

    $("#edit_letter_#{hex.q}_#{hex.r}").remove()

    div = $("<div>#{hex.data.color.toUpperCase()}</div>")
    div.css( 'top', y-12 )
    div.css( 'left', x-5 )
    div.addClass( 'edit_terrain_type' )
    div.attr( 'id', "edit_letter_#{hex.q}_#{hex.r}" )
    div.css( 'color', 'red' ) if hex.color == 'r' || hex.color == 'R'
    $('#board').append( div )


  clear_letter: ( hex ) ->
    @terrain_map.hclear( hex )
    $("#edit_letter_#{hex.q}_#{hex.r}").remove()


  set_map_letters: () ->
    searchParams = new URLSearchParams(window.location.search)
    color = searchParams.get('color')
    color = color.toUpperCase() if color

    for _, hex of @terrain_map.hexes

      if color == hex.data.color.toUpperCase()
        @set_letter( hex, true )

  load_top_layer: () ->
    for hex in @top_layer
      hex = new AxialHex( parseInt(hex['q']), parseInt(hex['r']), { color: hex.data.color } )
      @set_letter( hex, true )
