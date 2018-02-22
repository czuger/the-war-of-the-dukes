# This class represents the pawns on the map.

class @PawnsOnMap extends AxialGrid

  build_hex_keys_hash: () ->
    h = {}
    for key, hex of @hexes
      h[ hex.hex_key() ] = true
    h
