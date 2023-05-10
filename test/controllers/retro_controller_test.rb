require "test_helper"

class RetroControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get retro_index_url
    assert_response :success
  end
end
