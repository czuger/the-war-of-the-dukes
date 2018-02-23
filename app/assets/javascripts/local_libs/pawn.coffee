# This class represents a pawn on the map.

class @Pawn

  PAWNS_TYPES = { 'inf' : 'infantry', 'art' : 'artillery', 'cav' : 'cavalry' }
  PAWNS_MOVEMENTS = { 'art': 3, 'cav': 6, 'inf': 3 }

  constructor: ( @q, @r, @pawn_type, @side ) ->

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
  set_jquery_object: ( @jquery_object ) ->

  # Reposition the pawn to another place
  reposition: ( @q, @r ) ->

  # Clone a pawn
  shallow_clone: () ->
    p = new Pawn( @q, @r, @pawn_type, @side )
    p.set_jquery_object( @jquery_object )
    p

  # Return the movement amount of a pawn
  movement: () ->
    PAWNS_MOVEMENTS[@pawn_type]

