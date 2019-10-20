require 'test_helper'

class PawnsControllerTest < ActionDispatch::IntegrationTest
  setup do
		discord_fake_login_and_board_create
		@pawn = create( :pawn, board: @board )
  end

  # test 'should get update' do
		# patch board_pawn_url( @board, @pawn ), params: { q: 10, r: 21, has_moved: true }
  #   assert_response :success
  # end

  # test "should get delete" do
  #   get pawns_delete_url
  #   assert_response :success
  # end

end
