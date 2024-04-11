require "application_system_test_case"

class ApiCallRecordsTest < ApplicationSystemTestCase
  setup do
    @api_call_record = api_call_records(:one)
  end

  test "visiting the index" do
    visit api_call_records_url
    assert_selector "h1", text: "Api call records"
  end

  test "should create api call record" do
    visit api_call_records_url
    click_on "New api call record"

    fill_in "Log", with: @api_call_record.log
    fill_in "Post", with: @api_call_record.post_id
    fill_in "Post target", with: @api_call_record.post_target_id
    fill_in "Status code", with: @api_call_record.status_code
    fill_in "User", with: @api_call_record.user_id
    click_on "Create Api call record"

    assert_text "Api call record was successfully created"
    click_on "Back"
  end

  test "should update Api call record" do
    visit api_call_record_url(@api_call_record)
    click_on "Edit this api call record", match: :first

    fill_in "Log", with: @api_call_record.log
    fill_in "Post", with: @api_call_record.post_id
    fill_in "Post target", with: @api_call_record.post_target_id
    fill_in "Status code", with: @api_call_record.status_code
    fill_in "User", with: @api_call_record.user_id
    click_on "Update Api call record"

    assert_text "Api call record was successfully updated"
    click_on "Back"
  end

  test "should destroy Api call record" do
    visit api_call_record_url(@api_call_record)
    click_on "Destroy this api call record", match: :first

    assert_text "Api call record was successfully destroyed"
  end
end
