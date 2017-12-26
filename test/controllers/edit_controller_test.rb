require 'test_helper'

class EditControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get edit_show_url
    assert_response :success
  end

end
