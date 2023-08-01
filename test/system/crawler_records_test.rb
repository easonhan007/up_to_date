require "application_system_test_case"

class CrawlerRecordsTest < ApplicationSystemTestCase
  setup do
    @crawler_record = crawler_records(:one)
  end

  test "visiting the index" do
    visit crawler_records_url
    assert_selector "h1", text: "Crawler records"
  end

  test "should create crawler record" do
    visit crawler_records_url
    click_on "New crawler record"

    fill_in "Crawler setting", with: @crawler_record.crawler_setting_id
    fill_in "Failed", with: @crawler_record.failed
    fill_in "Success", with: @crawler_record.success
    fill_in "Url count", with: @crawler_record.url_count
    fill_in "Urls", with: @crawler_record.urls
    click_on "Create Crawler record"

    assert_text "Crawler record was successfully created"
    click_on "Back"
  end

  test "should update Crawler record" do
    visit crawler_record_url(@crawler_record)
    click_on "Edit this crawler record", match: :first

    fill_in "Crawler setting", with: @crawler_record.crawler_setting_id
    fill_in "Failed", with: @crawler_record.failed
    fill_in "Success", with: @crawler_record.success
    fill_in "Url count", with: @crawler_record.url_count
    fill_in "Urls", with: @crawler_record.urls
    click_on "Update Crawler record"

    assert_text "Crawler record was successfully updated"
    click_on "Back"
  end

  test "should destroy Crawler record" do
    visit crawler_record_url(@crawler_record)
    click_on "Destroy this crawler record", match: :first

    assert_text "Crawler record was successfully destroyed"
  end
end
