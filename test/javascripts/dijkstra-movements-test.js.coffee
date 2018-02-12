#assert = require('assert')

describe 'DijkstraMovements', ->

  beforeEach ->
    @ag = new AxialGrid( 25.7 )
    @ag.from_json( map_json_string );
    @hex = new AxialHex( 13, 4 )

  describe '#calc()', ->

    it 'should reach target', ->
      result = DijkstraMovements.calc( @ag, movement_graph, @hex, 6 )

      result.should.include('12_4')
      result.should.include('13_5')
      result.should.include('2_3')

      result.should.include( '3_3')
      result.should.include( '2_3')
      result.should.not.include( '2_2')

      result.should.include( '16_1')
      result.should.include( '8_-1')
      result.should.include( '19_-1')
      result.should.include( '19_-2')
      result.should.not.include( '20_-3')
