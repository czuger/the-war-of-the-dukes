# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

# A phantom pawns DB. Also for callback usage
root.phantom_pawn_db = {}

# This class is used to handle movements on map
class @MovementEngine
  
  OPPOSITE_SIDE = { 'orf': 'wulf', 'wulf': 'orf' }

  constructor: ->
    @side = root.board.side

  start_movement: ( jquery_pawn ) ->

    MovementEngine.clear_phantoms()

    pawns_on_map = root.board.pawns_on_map
    terrain_map = root.board.terrain_map

    pawn = pawns_on_map.get( jquery_pawn.attr('id') )

    controlled_hexes = pawns_on_map.controlled_hexes( terrain_map, OPPOSITE_SIDE[ pawn.side ] )
  #  console.log( controlled_hexes )

    [results, results_costs] = DijkstraMovements.compute_movements( root.board, pawn ,controlled_hexes )
  #  console.log( results )
  #  console.log( results_costs )
    last_selected_pawn = pawn

    for key in results
      [q, r] = AxialHex.parse_hex_key( key )

      phantom_pawn = new PawnMovementPhantom( pawn, results_costs[key] )
      phantom_pawn.reposition( parseInt(q), parseInt(r) )
      phantom_pawn.show_on_map( pawns_on_map, pawn.css_id() )
      root.phantom_pawn_db[phantom_pawn.css_id()] = phantom_pawn

    @manage_movement()
    null

  manage_movement: () ->
    $('.pawn_phantom').click ->

      pawns_on_map = root.board.pawns_on_map

      phantom_pawn_id = $(this).attr('id')
      phantom_pawn = root.phantom_pawn_db[phantom_pawn_id]

      last_selected_pawn_id = phantom_pawn.origin_pawn_id
      new_q = phantom_pawn.q
      new_r = phantom_pawn.r

      old_pawn = pawns_on_map.get(last_selected_pawn_id)
      new_pawn = old_pawn.shallow_clone()
      new_pawn.reposition( new_q, new_r )
      new_pawn.set_remaining_movement( phantom_pawn.remaining_movement )

      new_pawn.db_update(
        (data) ->
          pawns_on_map.clear( old_pawn )
          $('#'+last_selected_pawn_id).remove()

          pawns_on_map.set( new_pawn )
          pawns_on_map.place_on_screen_map(new_pawn)

          MovementEngine.clear_phantoms()

          root.combat_engine.combat_on()
      )

  # This method clears all phantoms.
  @clear_phantoms: ->
    $('.pawn_phantom').remove()
    root.phantom_pawn_db = {}
