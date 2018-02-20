# This class is used to ensure that there is only one pawn at one hex
#
# @author Cédric ZUGER
#

class PawnUnicity

  # Create a PawnsUnicity object
  constructor: ( jquery_pawn ) ->
    @hex = new AxialHex( parseInt(jquery_pawn.attr( 'q' )), parseInt(jquery_pawn.attr( 'r' )) )


class @PawnsUnicity

  # Create a PawnsUnicity object
  constructor: () ->
    @pawns_list = {}


  add_hex: ( q, r ) ->
    hex = new AxialHex( q, r )
    @pawns_list[ [ parseInt(hex.q), parseInt(hex.r) ] ] = hex


  move_hex: ( old_jquery_pawn, new_jquery_pawn ) ->
    old_pu = new PawnUnicity( old_jquery_pawn )
    new_pu = new PawnUnicity( new_jquery_pawn )
    delete @pawns_list[ [ old_pu.hex.q, old_pu.hex.r ] ]
    @pawns_list[ [ new_pu.hex.q, new_pu.hex.r ] ] = new_pu.hex


  build_hex_key_exclusion_list: () ->
    hkxl = []

    for _, hex of @pawns_list
      hkxl.push( hex.hex_key() )

    hkxl