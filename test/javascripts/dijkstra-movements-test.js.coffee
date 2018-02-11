#assert = require('assert')

describe 'DijkstraMovements', ->

  beforeEach ->
    @ag = new AxialGrid( 25.7 )
    @ag.from_json( map_json_string );
    @hex = new AxialHex( 13, 4 )

  describe '#calc()', ->

    it 'should reach target', ->
      result = DijkstraMovements.calc( @ag, movement_graph, @hex, 6 )

      result.should.include(2)
