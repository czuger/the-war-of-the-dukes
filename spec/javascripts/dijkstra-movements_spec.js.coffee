#=require test_data.js

describe 'DijkstraMovements', ->

  beforeEach ->
    @hex = new AxialHex( 13, 4 )
    @map = new Map( map_json_string, movement_graph_json_string )

  describe '#compute_movements()', ->

    it 'should reach target', ->
      result = DijkstraMovements.compute_movements( @map, @hex, 6 )

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
