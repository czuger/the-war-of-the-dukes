describe 'Combat', ->

  beforeEach ->
    fixtures = fixture.load('combat.json')
    @board = new Board( fixtures[0] )

    att_1 = @board.pawns_on_map.get( 'pawn-orf-inf-12-4' )
    att_2 = @board.pawns_on_map.get( 'pawn-orf-art-12-5' )

    defender = @board.pawns_on_map.get( 'pawn-wulf-inf-11-4' )

    @fight = new PawnFight( @board, [ att_1, att_2 ], defender )

  it 'Should resolve a fight', ->
    @fight.resolve_fight()