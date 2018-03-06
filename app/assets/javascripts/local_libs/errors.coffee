# This class centralize all errors functions

class @Errors

  # basic error handler
  @basic_handler: (jqXHR, textStatus, errorThrown) ->
    $('#error_area').html(errorThrown)
    $('#error_area').show().delay(3000).fadeOut(3000);