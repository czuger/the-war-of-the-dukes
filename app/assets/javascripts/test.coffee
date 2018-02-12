# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = null
movement_graph = null

position_pawn = ( pawn_object, q, r, opacity=1, clone=false ) ->

  if clone
    new_object = clone_pawn( pawn_object, q, r )
  else
    new_object = pawn_object

  pos = new AxialHex( q, r )

  [ x, y ] = ag.hex_to_pixel_flat_topped( pos )

#  console.log( "x = ", x, "y = ", y )
#  console.log( new_object )

  new_object.css('top', y + 15 )
  new_object.css('left', x + 15 )
  new_object.css( 'opacity', opacity )

clone_pawn = ( pawn_object, q, r ) ->
  item = pawn_object.clone()
  item.attr( 'id', 'tmp_inf_' + q + '_' + r )
  item.attr( 'q', q )
  item.attr( 'r', r )
  item.appendTo( 'body' )
  item

load = () ->
  ag = new AxialGrid( 26 )

  map = $('#map')
  if map.length != 0
    ag.from_json( map.val() )

  movement_graph = $('#movement_hash')
  if movement_graph.length != 0
    movement_graph = JSON.parse( movement_graph.val() )
#  console.log( movement_graph )

  $('#board').mousemove (event) ->

    [ hex, hex_info ] = MapMethods.get_current_hex(ag, event)

    $('#hex_info').css('top',event.pageY-20)
    $('#hex_info').css('left',event.pageX+30)
    $('#hex_info').show()
    $('#hex_info').html(hex_info)

    position_pawn( $('#orf_infantery_1'), 13, 4 )
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