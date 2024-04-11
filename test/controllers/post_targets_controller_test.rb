require "test_helper"

class PostTargetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_target = post_targets(:one)
  end

  test "should get index" do
    get post_targets_url
    assert_response :success
  end

  test "should get new" do
    get new_post_target_url
    assert_response :success
  end

  test "should create post_target" do
    assert_difference("PostTarget.count") do
      post post_targets_url, params: { post_target: { api: @post_target.api, field_mapping: @post_target.field_mapping, headers: @post_target.headers, key: @post_target.key, success_code: @post_target.success_code } }
    end

    assert_redirected_to post_target_url(PostTarget.last)
  end

  test "should show post_target" do
    get post_target_url(@post_target)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_target_url(@post_target)
    assert_response :success
  end

  test "should update post_target" do
    patch post_target_url(@post_target), params: { post_target: { api: @post_target.api, field_mapping: @post_target.field_mapping, headers: @post_target.headers, key: @post_target.key, success_code: @post_target.success_code } }
    assert_redirected_to post_target_url(@post_target)
  end

  test "should destroy post_target" do
    assert_difference("PostTarget.count", -1) do
      delete post_target_url(@post_target)
    end

    assert_redirected_to post_targets_url
  end
end
