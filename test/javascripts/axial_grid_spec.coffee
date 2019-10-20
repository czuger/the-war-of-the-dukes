#assert = require('assert')

describe 'AxialGrid', ->

  beforeEach ->
    @map = new AxialGrid( 16 )

  describe '#hex_to_pixel_flat_topped()', ->

    it 'should return the right value', ->
      expect( @map.hex_to_pixel_flat_topped( new AxialHex( 0, 0 ) ) ).toEqual( [ 12, 14 ] );

    it 'should return the right value for next hex', ->
      expect( @map.hex_to_pixel_flat_topped( new AxialHex( 1, 0 ) ) ).toEqual( [ 36, 28 ] );