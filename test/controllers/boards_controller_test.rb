require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
		discord_fake_login_and_board_create
  end

  test 'should get index' do
    get boards_url
    assert_response :success
  end

  test 'should get new' do
    get new_board_url
    assert_response :success
  end

  test 'should create a board' do
    assert_difference('Board.count') do
      post boards_url, params: { side: :wulf, opponent_id: @player1.id, owner_id: @player2.id }
    end

    assert_redirected_to boards_url
  end

  # test 'should update a board' do
  #   @board.orf_move_turn!
  #   @board.orf_fight_turn!
  #   patch board_url( @player1, @board ), params: { board: { fight_data: { q: 11, r: 4, foo: :bar }, turn: 3, switch_board_state: 'wulf_retreat_pawn'} }
	#
  #   # p @board.reload
  #   assert @board.fight_data['q'] == '11'
  #   assert @board.turn == 3
  #   assert @board.wulf_retreat?
  #   refute@board.fight_data['foo'] == 'bar'
  #   assert_response :success
  # end

end
