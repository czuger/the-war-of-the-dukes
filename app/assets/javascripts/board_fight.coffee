# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# A map for the terrain
terrain_map = null
# A map for the pawns
pawns_on_map = null

opponent_selected = null

# On server communication error method
on_error_put_pawn_on_map = (jqXHR, textStatus, errorThrown) ->
  $('#error_area').html(errorThrown)
  $('#error_area').show().delay(3000).fadeOut(3000);

on_side_click = (event, jquery_object) ->
  if jquery_object.hasClass('attacker')
    jquery_object.removeClass('attacker')
  else
    jquery_object.addClass('attacker')

  null

on_opponent_click = (event, jquery_object) ->
  if jquery_object.hasClass('defender')
    jquery_object.removeClass('defender')
    opponent_selected = 0
  else
    if opponent_selected == 0
      jquery_object.addClass('defender')
      opponent_selected = 1

  null

load = () ->
  terrain_map = new Map()
  pawns_on_map = new PawnsOnMap( terrain_map )
  side = $('#side').val()
  opponent = $('#opponent').val()
  opponent_selected = 0

  pawns_on_map.load_pawns()

  $(".#{side}").click (event) ->
    on_side_click(event, $(this))

  $(".#{opponent}").click (event) ->
    on_opponent_click(event, $(this))

$ ->
  if window.location.pathname.match( /players\/\d+\/boards\/\d+\/fight/ )
    load()