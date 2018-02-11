# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ag = null
movement_graph = null

load = () ->
  ag = new AxialGrid( 25.7 )

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

  pos = new AxialHex( 14, 4 )
  [ x, y ] = ag.hex_to_pixel_flat_topped( pos )

  console.log( x, y )
  console.log( Math.round( x ), Math.round( y ) )
  console.log( $('#orf_infantery_1') )

  $('#orf_infantery_1').css('top', Math.round( y ) )
  $('#orf_infantery_1').css('left', Math.round( x )-17 )

  $('#orf_infantery_1').mousedown (event) ->

    [ hex, _ ] = MapMethods.get_current_hex(ag, event)
    console.log( hex )


#    console.log( hex )
    result = DijkstraMovements.calc( ag, movement_graph, hex, 6 )
    console.log( result )

    for key in result
      # console.log( walkable_position )

      [top, left] = key.split( '_' )
#      console.log( top, left )
      pos = new AxialHex( top, left )
      [ x, y ] = ag.hex_to_pixel_flat_topped( pos )
      item = $('#orf_infantery_1').clone()
      item.id = 'tmp_inf_' + key
      item.appendTo( 'body' )

      item.css( 'top', Math.round( y ) )
      item.css( 'left', Math.round( x )-17 )
      item.css( 'opacity', 0.7 )

$(window).load ->
  load()