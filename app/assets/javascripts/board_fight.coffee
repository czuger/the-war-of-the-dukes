# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# A map for the terrain
terrain_map = null
# A map for the pawns
pawns_on_map = null

opponent_selected = null
side = null

attack_value = null
defence_value = null

result_table = null

update_fight_infos = (jquery_object) ->
  if opponent_selected == 1
    defender_pawn = pawns_on_map.get( $('.defender').first().attr('id') )
    surrounding_hexes = terrain_map.map_hexes.hexes_at_range( defender_pawn.get_hex(), 2 )

    attack_value = 0
    attacking_units = []
    for s_hex in surrounding_hexes
      attacker_pawn = pawns_on_map.get_from_hex( s_hex )
      if attacker_pawn && attacker_pawn.side == side && attacker_pawn.get_jquery_object().hasClass('attacker')
        attacker_value = PawnFight.check_attack_value(defender_pawn, attacker_pawn, terrain_map)
        if attacker_value > 0
          attacking_units.push( attacker_pawn )
          attack_value += attacker_value

    defence_value = PawnFight.defence_value(defender_pawn, terrain_map)

    attacker_list_html = (attacking_units.map (u) -> "<li>#{u.pawn_type}</li>").join('')
    attacker_list_html = "<ul>#{attacker_list_html}</ul>"
    $('#attacking_units').html(attacker_list_html)
    $('#attack_amount').html('Att value : ' + attack_value)
    $('#defence_amount').html('Def value : ' + defence_value)

#    frac = new algebra.Fraction(attack_value, defence_value)
#    frac = frac.add(new algebra.Fraction(0, 1))

    ratio_string = PawnFight.attack_defence_ratio_string( attack_value, defence_value )
    $('#ratio').html(ratio_string)

on_side_click = (event, jquery_object) ->
  if jquery_object.hasClass('attacker')
    jquery_object.removeClass('attacker')
  else
    jquery_object.addClass('attacker')

  update_fight_infos(jquery_object)
  null

on_opponent_click = (event, jquery_object) ->
  if jquery_object.hasClass('defender')
    jquery_object.removeClass('defender')
    opponent_selected = 0
  else
    if opponent_selected == 0
      jquery_object.addClass('defender')
      opponent_selected = 1

  update_fight_infos(jquery_object)
  null

on_fight_button_clicked = () ->
  defender_pawn = pawns_on_map.get( $('.defender').first().attr('id') )
  PawnFight.basic_fight( defender_pawn, attack_value, defence_value, result_table, terrain_map )

load = () ->
  terrain_map = new Map()
  pawns_on_map = new PawnsOnMap( terrain_map )
  side = $('#side').val()
  opponent = $('#opponent').val()
  opponent_selected = 0
  result_table = JSON.parse( $('#result_table').val() )

  pawns_on_map.load_pawns()

  $(".#{side}").click (event) ->
    on_side_click(event, $(this))

  $(".#{opponent}").click (event) ->
    on_opponent_click(event, $(this))

  $('#fight_button').click () ->
    on_fight_button_clicked()

$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/fight/ )
    load()