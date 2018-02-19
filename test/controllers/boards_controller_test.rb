require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player1 = create( :player )
    @player2 = create( :player )
    @board = create( :board, owner: @player1, opponent: @player2 )
  end

  test "should get index" do
    get player_boards_url( @player1 )
    assert_response :success
  end

  test "should get new" do
    get new_player_board_url( @player1 )
    assert_response :success
  end

  test "should create board" do
    assert_difference('Board.count') do
      post player_boards_url( @player1 ), params: { board: { opponent_id: @board.opponent_id, owner_id: @board.owner_id, turn: @board.turn } }
    end

    assert_redirected_to player_boards_url( @player1 )
  end

end
