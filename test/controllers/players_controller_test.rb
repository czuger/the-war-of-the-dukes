require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = create( :player )
  end

  test "should get index" do
    get players_url
    assert_response :success
  end

  test "should get new" do
    get new_player_url
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post players_url, params: { player: { name: @player.name } }
    end

    assert_redirected_to players_url
  end

end
