# This class represents a pawn on the map.

class @PawnFight

  PAWNS_ATTACK = { 'art': 3, 'cav': 2, 'inf': 5 }
  DEFENCE_TERRAIN_MODIFIER = { 'c': 2, 'b': 3 }
  DEFENCE_TERRAIN_DICE_MODIFIER = { 'f': 2, 'h': 1 }

  # Check if two pawns can attack themselves and return the attack_amount
  @check_attack_value: ( defender, attacker, terrain_map ) ->
    movement_hash = terrain_map.movement_graph
    defender_hex = defender.get_hex()
    attacker_hex = attacker.get_hex()
    dist = defender_hex.distance( attacker_hex )
    terrain_value = terrain_map.map_hexes.hget( attacker_hex ).data.color
#    atm = if ATTACK_TERAIN_MODIFIER[terrain_value] then ATTACK_TERAIN_MODIFIER[terrain_value] else 0

    if ( attacker.pawn_type == 'cav' || attacker.pawn_type == 'inf' ) && dist == 1
      if movement_hash[ [ defender_hex.hex_key(), attacker_hex.hex_key() ].join( '_' ) ] <= 2
        return PAWNS_ATTACK[attacker.pawn_type]

    if ( attacker.pawn_type == 'art' ) && dist <= 2
      return PAWNS_ATTACK[attacker.pawn_type]

    return 0

  # Return the defence value of the unit
  @defence_value: ( defender, terrain_map ) ->
    defender_hex = defender.get_hex()
    terrain_value = terrain_map.map_hexes.hget( defender_hex ).data.color
    dtm = if DEFENCE_TERRAIN_MODIFIER[terrain_value] then DEFENCE_TERRAIN_MODIFIER[terrain_value] else 1

    PAWNS_ATTACK[defender.pawn_type] * dtm

  # Return the ratio string
  @attack_defence_ratio_string: ( attack_value, defence_value ) ->
    if attack_value > defence_value
      return '-' if defence_value == 0
      return Math.round( attack_value/defence_value ) + '-1'
    else
      return '-' if attack_value == 0
      return '1-' + Math.round( defence_value/attack_value )