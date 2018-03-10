#assert = require('assert')

describe 'AxialGrid', ->

  beforeEach ->
    @map = new AxialGrid( 16 )

  describe '#hex_to_pixel_flat_topped()', ->

    it 'should return the right value', ->
      @map.hex_to_pixel_flat_topped( new AxialHex( 0, 0 ) ).should.eql [ 12, 14 ]

    it 'should return the right value for next hex', ->
      @map.hex_to_pixel_flat_topped( new AxialHex( 1, 0 ) ).should.eql [ 36, 28 ]