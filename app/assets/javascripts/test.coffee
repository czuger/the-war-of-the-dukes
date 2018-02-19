# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null
movement_graph = null
last_selected_pawn = null

print_mouse_info = () ->
  $('#board').mousemove (event) ->

    [ hex, hex_info ] = map.get_current_hex(event)

    html = ''
    for info in hex_info
      html += "<div>#{info}</div>"

    $('#hex_info').html(html)


on_pawn_click = (event, pawn) ->
  [ hex, _ ] = map.get_current_hex(event)

  result = DijkstraMovements.calc( map, hex, 6 )
  last_selected_pawn = pawn

  for key in result
    [q, r] = key.split( '_' )

    map.pawn_module.create_phantom( pawn, parseInt(q), parseInt(r) )

  manage_movement()
  null


manage_movement = () ->
  $('.pawn_phantom').click ->
    $(this).removeClass('pawn_phantom')
    $(this).addClass('pawn')

    last_selected_pawn.remove()

    $('.pawn_phantom').remove()

    $(this).click (event) ->
      on_pawn_click(event, $(this))


load = () ->
  print_mouse_info()

  map = new Map()

  pawn = map.pawn_module.put_on_map( $('#orf_infantery_1'), 14, 4 )

  pawn.click (event) ->
    on_pawn_click(event, $(this))


$ ->
  if window.location.pathname == '/' || window.location.pathname == '/test/show'
    load()