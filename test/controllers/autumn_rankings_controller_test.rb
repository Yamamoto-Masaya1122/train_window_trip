require "test_helper"

class AutumnRankingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get autumn_rankings_index_url
    assert_response :success
  end
end
