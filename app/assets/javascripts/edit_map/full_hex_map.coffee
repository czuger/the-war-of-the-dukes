# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

print_mouse_info = ( board ) ->
  $('#board').mousemove (event) ->

    hex_info = board.terrain_map.get_current_hex_info(event)

    html = ''
    for info in hex_info
      html += "<div>#{info}</div>"

    $('#hex_info').html(html)

load = ( board ) ->

    show_center = ($('#show_centers').val() == 'true')

    print_mouse_info( board )

    for q in [0..31]
      for r in [-9..22]
        if board.terrain_map.in_border( new AxialHex( q, r ) )
          if show_center
            board.terrain_map.show_hex_center( q, r )
          else
            board.pawns_on_map.place_on_screen_map( new Pawn( q, r, 'inf', 'orf' ), true )

    # Required to show svg elements
    $("body").html($("body").html()) if show_center

$ ->
  if window.location.pathname == '/edit_map/full_hex_map'
    Board.load_map( load )