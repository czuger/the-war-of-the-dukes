# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

# An object to store all board related information
root.board = null

# Global combat and movement engines
root.combat_engine = null
root.movement_engine = null

load = ( board ) ->
  root.board = board

  root.combat_engine = new CombatEngine
  root.movement_engine = new MovementEngine

  root.combat_engine.combat_on()


$ ->
  if window.location.pathname.match( /boards\/\d+\/action/ )

    board_id_regex = RegExp('\\d+');
    board_id = board_id_regex.exec( window.location.pathname )[0]

    Board.load_map( load, { board_id: board_id, movement: true } )