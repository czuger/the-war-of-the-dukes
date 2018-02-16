# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = null
movement_graph = null

print_mouse_info = () ->
  $('#board').mousemove (event) ->

    [ hex, hex_info ] = ag.get_current_hex(event)

    html = ''
    for info in hex_info
      html += "<div>#{info}</div>"

    $('#hex_info').html(html)

load = () ->
  print_mouse_info()

  map_json = $('#map')
  movement_graph_json = $('#movement_hash')

  ag = null
  if map_json.length != 0 && movement_graph_json.length != 0
    ag = new Map( map_json.val(), movement_graph_json.val() )

  pawn = ag.position_pawn( $('#orf_infantery_1'), 14, 4, 1, true )

  pawn.mousedown (event) ->

    [ hex, _ ] = ag.get_current_hex(event)

    result = DijkstraMovements.calc( ag, hex, 6 )

    for key in result
      [q, r] = key.split( '_' )

      ag.position_pawn( $('#orf_infantery_1'), parseInt(q), parseInt(r), 0.5, true )

    null

$(window).load ->
  load()