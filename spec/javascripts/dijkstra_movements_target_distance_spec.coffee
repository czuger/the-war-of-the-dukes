describe 'DijkstraMovements', ->

  beforeEach ->
    fixtures = fixture.load('dijkstra_movement_target_distance.json')
    @board = new Board( fixtures[0] )

    @bad_attacker = @board.pawns_on_map.get( 'pawn-orf-cav-29-6' )

  describe '#target_distance()', ->

    it 'should not be able to attack because it is too far', ->

      bad_attacker_1 = @board.pawns_on_map.get( 'pawn-orf-inf-21--4' )
      good_defender_1 = @board.pawns_on_map.get( 'pawn-wulf-cav-19--3' )

      result = DijkstraMovements.target_distance( @board, bad_attacker_1, good_defender_1 )
      result.should.be.false


    it 'should cross the river in front of it, but not the neighbour river', ->

      good_attacker_1 = @board.pawns_on_map.get( 'pawn-orf-inf-12-4' )
      good_defender_1 = @board.pawns_on_map.get( 'pawn-wulf-inf-11-4' )

      good_attacker_2 = @board.pawns_on_map.get( 'pawn-orf-inf-13-3' )
      good_defender_2 = @board.pawns_on_map.get( 'pawn-wulf-inf-13-2' )


      result = DijkstraMovements.target_distance( @board, good_attacker_1, good_defender_1 )
      result.should.be.true

      result = DijkstraMovements.target_distance( @board, good_attacker_2, good_defender_2 )
      result.should.be.true

      result = DijkstraMovements.target_distance( @board, good_attacker_2, good_defender_1 )
      result.should.be.false

      result = DijkstraMovements.target_distance( @board, good_attacker_1, good_defender_2 )
      result.should.be.false

#      result = DijkstraMovements.target_distance( @board, @bad_attacker, @good_defender_1 )
#      result.should.be.false


