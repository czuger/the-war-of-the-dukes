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


  create_phantom: (hex) ->
    new_object = $('<div>')
    new_object.attr( 'id', "pawn_phantom_#{hex.q}_#{hex.r}")
    new_object.addClass('pawn_phantom')
    new_object.addClass( @pawn_class( hex ) )
    new_object = @position( new_object, hex.q, hex.r )
    new_object.appendTo( '#board' )
    new_object


