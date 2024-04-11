require "application_system_test_case"

class PostTargetsTest < ApplicationSystemTestCase
  setup do
    @post_target = post_targets(:one)
  end

  test "visiting the index" do
    visit post_targets_url
    assert_selector "h1", text: "Post targets"
  end

  test "should create post target" do
    visit post_targets_url
    click_on "New post target"

    fill_in "Api", with: @post_target.api
    fill_in "Field mapping", with: @post_target.field_mapping
    fill_in "Headers", with: @post_target.headers
    fill_in "Key", with: @post_target.key
    fill_in "Success code", with: @post_target.success_code
    click_on "Create Post target"

    assert_text "Post target was successfully created"
    click_on "Back"
  end

  test "should update Post target" do
    visit post_target_url(@post_target)
    click_on "Edit this post target", match: :first

    fill_in "Api", with: @post_target.api
    fill_in "Field mapping", with: @post_target.field_mapping
    fill_in "Headers", with: @post_target.headers
    fill_in "Key", with: @post_target.key
    fill_in "Success code", with: @post_target.success_code
    click_on "Update Post target"

    assert_text "Post target was successfully updated"
    click_on "Back"
  end

  test "should destroy Post target" do
    visit post_target_url(@post_target)
    click_on "Destroy this post target", match: :first

    assert_text "Post target was successfully destroyed"
  end
end
