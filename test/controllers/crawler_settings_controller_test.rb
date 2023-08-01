require "test_helper"

class CrawlerSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crawler_setting = crawler_settings(:one)
  end

  test "should get index" do
    get crawler_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_crawler_setting_url
    assert_response :success
  end

  test "should create crawler_setting" do
    assert_difference("CrawlerSetting.count") do
      post crawler_settings_url, params: { crawler_setting: { detail_page_content_css: @crawler_setting.detail_page_content_css, detail_page_title_css: @crawler_setting.detail_page_title_css, index_page_css: @crawler_setting.index_page_css, index_page_url: @crawler_setting.index_page_url, name: @crawler_setting.name, user_id: @crawler_setting.user_id } }
    end

    assert_redirected_to crawler_setting_url(CrawlerSetting.last)
  end

  test "should show crawler_setting" do
    get crawler_setting_url(@crawler_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_crawler_setting_url(@crawler_setting)
    assert_response :success
  end

  test "should update crawler_setting" do
    patch crawler_setting_url(@crawler_setting), params: { crawler_setting: { detail_page_content_css: @crawler_setting.detail_page_content_css, detail_page_title_css: @crawler_setting.detail_page_title_css, index_page_css: @crawler_setting.index_page_css, index_page_url: @crawler_setting.index_page_url, name: @crawler_setting.name, user_id: @crawler_setting.user_id } }
    assert_redirected_to crawler_setting_url(@crawler_setting)
  end

  test "should destroy crawler_setting" do
    assert_difference("CrawlerSetting.count", -1) do
      delete crawler_setting_url(@crawler_setting)
    end

    assert_redirected_to crawler_settings_url
  end
end
