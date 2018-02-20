# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null
movement_graph = null
last_selected_pawn = null
pawn_unicity_list = null

print_mouse_info = () ->
  $('#board').mousemove (event) ->

    [ hex, hex_info ] = map.get_current_hex(event)

    html = ''
    for info in hex_info
      html += "<div>#{info}</div>"

    $('#hex_info').html(html)


on_pawn_click = (event, pawn) ->
  [ hex, _ ] = map.get_current_hex(event)

  result = DijkstraMovements.compute_movements( map, hex, parseInt( pawn.attr( 'mov' ) ), pawn_unicity_list.build_hex_key_exclusion_list() )
  last_selected_pawn = pawn

  for key in result
    [q, r] = AxialHex.parse_hex_key( key )

    map.pawn_module.create_phantom( pawn, parseInt(q), parseInt(r) )

  manage_movement()
  null


manage_movement = () ->
  $('.pawn_phantom').click ->
    $(this).removeClass('pawn_phantom')
    $(this).addClass('pawn')

    pawn_unicity_list.move_hex( last_selected_pawn, $(this) )

    last_selected_pawn.remove()

    $('.pawn_phantom').remove()

    $.post "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/store_pawn_position",
      q: $(this).attr( 'q' )
      r: $(this).attr( 'r' )
      pawn_id: $(this).attr( 'pawn_id' )

    $(this).click (event) ->
      on_pawn_click(event, $(this))


put_pawn_on_map = ( pawn, q, r, pawn_id ) ->

  new_object = map.pawn_module.put_on_map( pawn, q, r )
  new_object.attr( 'pawn_id', pawn_id )

  new_object.click (event) ->
    on_pawn_click(event, $(this))


load = () ->
  print_mouse_info()

  map = new Map()
  pawn_unicity_list = new PawnsUnicity()

  pawn_type = { 'inf' : 'infantery', 'art' : 'artillery', 'cav' : 'cavalry' }

  pawns = JSON.parse( $('#pawns').val() )
  for pawn in pawns
    pawn_template_id = "##{pawn[3]}_#{pawn_type[pawn[2]]}_1"
    put_pawn_on_map( $(pawn_template_id), pawn[0], pawn[1], pawn[4] )
    pawn_unicity_list.add_hex( pawn[0], pawn[1] )


$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/play/ )
    load()