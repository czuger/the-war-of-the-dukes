class @MapMethods

  @get_current_hex: (ag, event) ->
    o = $('#board').offset()
    nx = event.pageX - o.left - ag.hex_ray
    ny = event.pageY - o.top - ag.hex_ray
    hex = ag.pixel_to_hex_flat_topped( nx, ny )

    if hex
      color = hex.color
      hex_info = "color = #{color}, x = #{event.pageX}, y = #{event.pageY}, nx = #{nx}, ny = #{ny}, q = #{hex.q}, r = #{hex.r}"
    else
      hex_info = "x = #{event.pageX}, y = #{event.pageY}, nx = #{nx}, ny = #{ny}"

    [ hex, hex_info ]
