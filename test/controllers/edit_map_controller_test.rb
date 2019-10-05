require 'test_helper'

class EditMapControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get edit_show_url
    assert_response :success
  end

end
