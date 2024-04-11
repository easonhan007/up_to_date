require "test_helper"

class ApiCallRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_call_record = api_call_records(:one)
  end

  test "should get index" do
    get api_call_records_url
    assert_response :success
  end

  test "should get new" do
    get new_api_call_record_url
    assert_response :success
  end

  test "should create api_call_record" do
    assert_difference("ApiCallRecord.count") do
      post api_call_records_url, params: { api_call_record: { log: @api_call_record.log, post_id: @api_call_record.post_id, post_target_id: @api_call_record.post_target_id, status_code: @api_call_record.status_code, user_id: @api_call_record.user_id } }
    end

    assert_redirected_to api_call_record_url(ApiCallRecord.last)
  end

  test "should show api_call_record" do
    get api_call_record_url(@api_call_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_call_record_url(@api_call_record)
    assert_response :success
  end

  test "should update api_call_record" do
    patch api_call_record_url(@api_call_record), params: { api_call_record: { log: @api_call_record.log, post_id: @api_call_record.post_id, post_target_id: @api_call_record.post_target_id, status_code: @api_call_record.status_code, user_id: @api_call_record.user_id } }
    assert_redirected_to api_call_record_url(@api_call_record)
  end

  test "should destroy api_call_record" do
    assert_difference("ApiCallRecord.count", -1) do
      delete api_call_record_url(@api_call_record)
    end

    assert_redirected_to api_call_records_url
  end
end
