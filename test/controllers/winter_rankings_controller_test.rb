require "test_helper"

class WinterRankingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get winter_rankings_index_url
    assert_response :success
  end
end
