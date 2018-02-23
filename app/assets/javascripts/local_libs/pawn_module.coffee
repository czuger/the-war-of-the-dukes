# This class contains the pawns functions
#
# @author Cédric ZUGER
#

class @PawnModule

  # Create a PawnModule object
  #
  # @param map [Map] a reference to the map
  constructor: ( @map ) ->


  update_pawn_position_in_db: (pawn) ->
    $.ajax "/players/#{$('#player_id').val()}/boards/#{$('#board_id').val()}/pawns/#{pawn.attr('pawn_id')}",
      type: 'PATCH'
      dataType: 'html'
      error: (jqXHR, textStatus, errorThrown) ->
        # $('body').append "AJAX Error: #{textStatus}" do something

