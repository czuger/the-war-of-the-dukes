# This class represents a pawn on the map.

class @PawnFight

  PAWNS_ATTACK = { 'art': 3, 'cav': 2, 'inf': 5 }
  DEFENCE_TERRAIN_MODIFIER = { 'c': 2, 'b': 3 }
  DEFENCE_TERRAIN_DICE_MODIFIER = { 'f': 2, 'h': 1 }
  RESULT_TABLE = {
    "1":{
      "1-5":"AR",
      "1-4":"AR",
      "1-3":"DR",
      "1-2":"DR",
      "1-1":"DR",
      "2-1":"DR",
      "3-1":"DR",
      "4-1":"DE",
      "5-1":"DE",
      "6-1":"DE"
    },
    "2":{
      "1-5":"AE",
      "1-4":"AR",
      "1-3":"AR",
      "1-2":"DR",
      "1-1":"DR",
      "2-1":"DR",
      "3-1":"DR",
      "4-1":"DR",
      "5-1":"DE",
      "6-1":"DE"
    },
    "3":{
      "1-5":"AE",
      "1-4":"AE",
      "1-3":"AR",
      "1-2":"AR",
      "1-1":"DR",
      "2-1":"DR",
      "3-1":"DR",
      "4-1":"DR",
      "5-1":"DE",
      "6-1":"DE"
    },
    "4":{
      "1-5":"AE",
      "1-4":"AE",
      "1-3":"AR",
      "1-2":"AR",
      "1-1":"AR",
      "2-1":"DR",
      "3-1":"DR",
      "4-1":"DR",
      "5-1":"DR",
      "6-1":"DE"
    },
    "5":{
      "1-5":"AE",
      "1-4":"AE",
      "1-3":"AE",
      "1-2":"AR",
      "1-1":"AR",
      "2-1":"AR",
      "3-1":"DR",
      "4-1":"DR",
      "5-1":"DR",
      "6-1":"EX"
    },
    "6":{
      "1-5":"AE",
      "1-4":"AE",
      "1-3":"AE",
      "1-2":"AR",
      "1-1":"AR",
      "2-1":"AR",
      "3-1":"AR",
      "4-1":"EX",
      "5-1":"EX",
      "6-1":"EX"
    }
  }

  constructor: ( @board, @attackers, @defender ) ->

  # The main action of the class
  resolve_fight: ->

    @set_combat_values()

    ratio_string = @attack_defence_ratio_string()
    roll = @getRandomIntInclusive( 1, 6 )
#    $('#final_roll').html(roll)
#    $('#modified_roll').html(roll+roll_modifier)

    modified_roll=roll+@roll_modifier
    modified_roll = 6 if roll > 6

    result = RESULT_TABLE[modified_roll.toString()][ratio_string]
#    $('#fight_result').html(result)

    result_string = "Ratio : #{ratio_string}\n" + "Jet : #{roll} + #{@roll_modifier} = #{modified_roll}\n" + "Resultat : #{result}"
#    alert( result_string )

    @combat_result_dispatcher( result, result_string )


  # Set the attack and defense value for the combat
  set_combat_values: () ->

    @attack_value = 0
    for attacker in @attackers
      @attack_value += @check_attack_value( @defender, attacker )

    @defence_value = @defence_value( @defender )

    defender_hex = @defender.get_hex()
    terrain_value = @board.terrain_map.hget( defender_hex ).data.color
    @roll_modifier = if DEFENCE_TERRAIN_DICE_MODIFIER[terrain_value] then DEFENCE_TERRAIN_DICE_MODIFIER[terrain_value] else 0
    # $('#bonus_dice').html(roll_modifier)


# Check if two pawns can attack themselves and return the attack_amount
  check_attack_value: ( defender, attacker ) ->
    movement_hash = @board.terrain_map.movement_graph
    defender_hex = defender.get_hex()
    attacker_hex = attacker.get_hex()
    dist = defender_hex.distance( attacker_hex )

    if ( attacker.pawn_type == 'cav' || attacker.pawn_type == 'inf' ) && dist == 1
      if movement_hash.cost( defender_hex, attacker_hex ) <= 2
#        console.log( movement_hash.cost( defender_hex, attacker_hex ) )
        return PAWNS_ATTACK[attacker.pawn_type]

    if ( attacker.pawn_type == 'art' ) && dist <= 2
      return PAWNS_ATTACK[attacker.pawn_type]

    return 0


  # Return the defence value of the unit
  defence_value: ( defender ) ->
    defender_hex = defender.get_hex()
    terrain_value = @board.terrain_map.hget( defender_hex ).data.color
    dtm = if DEFENCE_TERRAIN_MODIFIER[terrain_value] then DEFENCE_TERRAIN_MODIFIER[terrain_value] else 1

    PAWNS_ATTACK[defender.pawn_type] * dtm


  # Return the ratio string
  attack_defence_ratio_string:  ->
    if @attack_value > @defence_value
      return '1-1' if @defence_value == 0
      return Math.round( @attack_value/@defence_value ) + '-1'
    else
      return '1-1' if @attack_value == 0
      return '1-' + Math.round( @defence_value/@attack_value )


  getRandomIntInclusive: (min, max) ->
    min = Math.ceil(min);
    max = Math.floor(max);
    Math.floor(Math.random() * (max - min + 1)) + min


  combat_result_dispatcher: ( result, result_string ) ->
    switch result
      # Need to strignify @defender and @attackers otherwise they are transformed in a callback where they are empty.
      when 'DR' then new PawnRetreat( result, JSON.stringify(@defender), result_string ).set_retreat()
      when 'AR' then  new PawnRetreat( result, JSON.stringify(@attackers), result_string ).set_retreat()
      else alert( 'Unimplemented' )