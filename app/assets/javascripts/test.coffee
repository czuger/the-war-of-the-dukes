# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = null
movement_graph = null

print_mouse_info = () ->
  $('#board').mousemove (event) ->

    [ hex, hex_info ] = ag.get_current_hex(event)

#    $('#hex_info').css('top',event.pageY-20)
#    $('#hex_info').css('left',event.pageX+30)
  #  $('#hex_info').show()
    html = ''
    for info in hex_info
      html += "<div>#{info}</div>"

    $('#hex_info').html(html)

load = () ->

  ag = new Map

  print_mouse_info()


#  console.log( movement_graph )



#    position_pawn( $('#orf_infantery_1'), 13, 4 )
#  position_pawn( $('#orf_infantery_1'), 12, 4 )
#  for q in [1..20]
#    for r in [1..20]
#      position_pawn( $('#orf_infantery_1'), q, r, 1, true )

  $('#orf_infantery_1').mousedown (event) ->

    [ hex, _ ] = MapMethods.get_current_hex(ag, event)
#    console.log( hex )

#    console.log( hex )
    result = DijkstraMovements.calc( ag, movement_graph, hex, 6 )
#    console.log( result.sort() )

    for key in result
#      console.log( key )

      [q, r] = key.split( '_' )
#      console.log( 'q, r = ', q, r )

      position_pawn( $('#orf_infantery_1'), parseInt(q), parseInt(r), 0.5, true )

    null

$(window).load ->
  load()