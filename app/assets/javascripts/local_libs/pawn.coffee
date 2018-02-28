# This class represents a pawn on the map.

class @Pawn

  PAWNS_TYPES = { 'inf' : 'infantry', 'art' : 'artillery', 'cav' : 'cavalry' }
  PAWNS_MOVEMENTS = { 'art': 3, 'cav': 6, 'inf': 3 }
  PAWNS_ATTACK = { 'art': 3, 'cav': 2, 'inf': 5 }

  constructor: ( @q, @r, @pawn_type, @side, @database_id ) ->

  # Return an axial hex for the pawn
  get_hex: () ->
    new AxialHex( @q, @r )

  css_class: () ->
    "#{@side}_#{PAWNS_TYPES[@pawn_type]}_1"

  css_id: () ->
    "pawn_#{@q}_#{@r}"

  css_phantom_id: () ->
    "phantom_pawn_#{@q}_#{@r}"

  # Set the jquery object associated to the pawn
  get_jquery_object: () ->
    $( '#' + @css_id() )

  # Reposition the pawn to another place
  reposition: ( q, r ) ->
    @q = parseInt(q)
    @r = parseInt(r)

  # Set that the pawn has moved this turn
  set_has_moved: () ->
    @has_moved = true

  # Clone a pawn
  shallow_clone: () ->
    new Pawn( @q, @r, @pawn_type, @side, @database_id )

  # Return the movement amount of a pawn
  movement: () ->
    PAWNS_MOVEMENTS[@pawn_type]

  # Check if two pawns can attack themselves and return the attack_amount
  check_attack_value: ( attacker, movement_hash ) ->
    self_hex = @get_hex()
    attacker_hex = attacker.get_hex()
    dist = self_hex.distance( attacker_hex )

    if ( attacker.pawn_type == 'cav' || attacker.pawn_type == 'inf' ) && dist == 1
      if movement_hash[ [ self_hex.hex_key(), attacker_hex.hex_key() ].join( '_' ) ] <= 2
        return PAWNS_ATTACK[attacker.pawn_type]

    if ( attacker.pawn_type == 'art' ) && dist <= 2
      return PAWNS_ATTACK[attacker.pawn_type]

    return 0

  # Return the defence value of the unit
  defence_value: () ->
    PAWNS_ATTACK[@pawn_type]

  # Call the server to update a pawn position
  db_update: ( error_callback_function, success_callback_function ) ->
    request = $.ajax "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns/#{@database_id}",
      type: 'PATCH'
      data: "q=#{@q}&r=#{@r}&has_moved=#{@has_moved}"
    @db_call_callbacks(request, error_callback_function, success_callback_function)

  db_create: ( error_callback_function, success_callback_function ) ->
    request = $.post "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns",
      q: @q
      r: @r
      pawn_type: @pawn_type
      side: @side
    @db_call_callbacks(request, error_callback_function, success_callback_function)

  db_delete: ( error_callback_function, success_callback_function ) ->
    request = $.ajax "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns/#{@database_id}",
      type: 'DELETE'
    @db_call_callbacks(request, error_callback_function, success_callback_function)

  db_call_callbacks: (request, error_callback_function, success_callback_function) ->
    request.success (data) -> success_callback_function(data)
    request.error (jqXHR, textStatus, errorThrown) -> error_callback_function(jqXHR, textStatus, errorThrown)
    request