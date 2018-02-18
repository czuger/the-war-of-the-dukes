class @MapDecal

  # Get the xy position of an hexagon on the grid. Make corrections according to the deformation of the map.
  #
  # @param x [Int] the x coord
  # @param y [Int] the y coord
  #
  # @return an [x_decal, y_decal] array containing the x, y decal.
  @hex_to_xy_decal: ( x, y ) ->

    x_decal =0
    y_decal = 0

    xdecal_array = [[ 674, 5 ], [ 863, 3 ], [ 978, 2 ], [ 1053, 3 ], [ 1092, 2 ], [ 1134, 2 ] ]
    for decal in xdecal_array
      if x > decal[0]
        x_decal -= decal[1]

    if x < 173
      x_decal += 4

    if y > 608
      y_decal -= 2
      if x > 566
        x_decal -=3

    if y > 721
      y_decal -= 5

    if y > 832
      y_decal -= 2

    if x >= 173 && x <= 359 && y >= 387
      x_decal += 5

    if y >= 809 && x <= 100
      x_decal += 7

    if y >= 900
      if x >= 826
        x_decal -= 5
      if x >= 1050
        y_decal -= 5

    if x >= 670 && x <= 869
      x_decal += 2

    [ x_decal, y_decal ]