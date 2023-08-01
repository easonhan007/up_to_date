require "application_system_test_case"

class CrawlerSettingsTest < ApplicationSystemTestCase
  setup do
    @crawler_setting = crawler_settings(:one)
  end

  test "visiting the index" do
    visit crawler_settings_url
    assert_selector "h1", text: "Crawler settings"
  end

  test "should create crawler setting" do
    visit crawler_settings_url
    click_on "New crawler setting"

    fill_in "Detail page content css", with: @crawler_setting.detail_page_content_css
    fill_in "Detail page title css", with: @crawler_setting.detail_page_title_css
    fill_in "Index page css", with: @crawler_setting.index_page_css
    fill_in "Index page url", with: @crawler_setting.index_page_url
    fill_in "Name", with: @crawler_setting.name
    fill_in "User", with: @crawler_setting.user_id
    click_on "Create Crawler setting"

    assert_text "Crawler setting was successfully created"
    click_on "Back"
  end

  test "should update Crawler setting" do
    visit crawler_setting_url(@crawler_setting)
    click_on "Edit this crawler setting", match: :first

    fill_in "Detail page content css", with: @crawler_setting.detail_page_content_css
    fill_in "Detail page title css", with: @crawler_setting.detail_page_title_css
    fill_in "Index page css", with: @crawler_setting.index_page_css
    fill_in "Index page url", with: @crawler_setting.index_page_url
    fill_in "Name", with: @crawler_setting.name
    fill_in "User", with: @crawler_setting.user_id
    click_on "Update Crawler setting"

    assert_text "Crawler setting was successfully updated"
    click_on "Back"
  end

  test "should destroy Crawler setting" do
    visit crawler_setting_url(@crawler_setting)
    click_on "Destroy this crawler setting", match: :first

    assert_text "Crawler setting was successfully destroyed"
  end
end
