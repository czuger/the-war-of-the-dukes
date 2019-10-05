require 'test_helper'

class PawnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player1 = create( :player )
    @player2 = create( :player )
    @board = create( :board, owner: @player1, opponent: @player2 )
		@pawn = create( :pawn, board: @board )
  end

  test 'should get create' do
    post board_pawns_url( @board ), params: { q: 1, r: 1, pawn_type: :cav, side: :orf }
    assert_response :success
  end

  test 'should get update' do
		patch board_pawn_url( @board, @pawn ), params: { q: 10, r: 21, has_moved: true }
    assert_response :success
  end

  # test "should get delete" do
  #   get pawns_delete_url
  #   assert_response :success
  # end

end
