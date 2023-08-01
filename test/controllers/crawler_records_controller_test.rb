require "test_helper"

class CrawlerRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crawler_record = crawler_records(:one)
  end

  test "should get index" do
    get crawler_records_url
    assert_response :success
  end

  test "should get new" do
    get new_crawler_record_url
    assert_response :success
  end

  test "should create crawler_record" do
    assert_difference("CrawlerRecord.count") do
      post crawler_records_url, params: { crawler_record: { crawler_setting_id: @crawler_record.crawler_setting_id, failed: @crawler_record.failed, success: @crawler_record.success, url_count: @crawler_record.url_count, urls: @crawler_record.urls } }
    end

    assert_redirected_to crawler_record_url(CrawlerRecord.last)
  end

  test "should show crawler_record" do
    get crawler_record_url(@crawler_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_crawler_record_url(@crawler_record)
    assert_response :success
  end

  test "should update crawler_record" do
    patch crawler_record_url(@crawler_record), params: { crawler_record: { crawler_setting_id: @crawler_record.crawler_setting_id, failed: @crawler_record.failed, success: @crawler_record.success, url_count: @crawler_record.url_count, urls: @crawler_record.urls } }
    assert_redirected_to crawler_record_url(@crawler_record)
  end

  test "should destroy crawler_record" do
    assert_difference("CrawlerRecord.count", -1) do
      delete crawler_record_url(@crawler_record)
    end

    assert_redirected_to crawler_records_url
  end
end
