# This is a base class for all class that communicate with the server

class @DbCalls

  db_call_callbacks: (request, success_callback_function, error_callback_function) ->
    request.success (data) -> success_callback_function(data)
    request.error (jqXHR, textStatus, errorThrown) ->
      if error_callback_function
        error_callback_function(jqXHR, textStatus, errorThrown)
      else
        DbCalls.basic_error_handler(jqXHR, textStatus, errorThrown)
    request

  # basic error handler
  @basic_error_handler: (jqXHR, textStatus, errorThrown) ->
    $('#error_area').html(errorThrown)
    $('#error_area').show().delay(3000).fadeOut(3000);