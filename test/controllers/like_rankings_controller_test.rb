require "test_helper"

class LikeRankingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get like_rankings_index_url
    assert_response :success
  end
end
