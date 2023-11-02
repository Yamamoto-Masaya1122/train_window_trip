require "test_helper"

class SpringRankingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get spring_rankings_index_url
    assert_response :success
  end
end
