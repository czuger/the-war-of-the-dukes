require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get test_show_url
    assert_response :success
  end

end
