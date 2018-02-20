require 'test_helper'

class PawnsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get pawns_create_url
    assert_response :success
  end

  test "should get update" do
    get pawns_update_url
    assert_response :success
  end

  test "should get delete" do
    get pawns_delete_url
    assert_response :success
  end

end
