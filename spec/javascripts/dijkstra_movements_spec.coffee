describe 'DijkstraMovements', ->

  beforeEach ->
    fixtures = fixture.load('movement.json')
    @board = new Board( fixtures[0] )

    @pawn = @board.pawns_on_map.get( 'pawn-orf-cav-13-4' )

  describe '#compute_movements()', ->

    it 'should reach target', ->
      [result, dummy ] = DijkstraMovements.compute_movements( @board, @pawn, [] )

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
