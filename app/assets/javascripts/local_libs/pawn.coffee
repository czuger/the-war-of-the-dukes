# This class represents a pawn on the map.

class @Pawn

  PAWNS_TYPES = { 'inf' : 'infantry', 'art' : 'artillery', 'cav' : 'cavalry' }
  PAWNS_MOVEMENTS = { 'art': 3, 'cav': 6, 'inf': 3 }

  constructor: ( @q, @r, @pawn_type, @side ) ->
    @hex = new AxialHex( @q, @r )

  css_class: () ->
    "#{@side}_#{PAWNS_TYPES[@pawn_type]}_1"

  css_id: () ->
    "pawn_#{@q}_#{@r}"

  css_phantom_id: () ->
    "phantom_pawn_#{@q}_#{@r}"

  set_jquery_object: ( @jquery_object ) ->
