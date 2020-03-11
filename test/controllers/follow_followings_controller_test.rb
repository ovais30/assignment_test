require 'test_helper'

class FollowFollowingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get follow_followings_index_url
    assert_response :success
  end

  test "should get create" do
    get follow_followings_create_url
    assert_response :success
  end

end
