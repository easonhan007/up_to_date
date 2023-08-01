json.extract! crawler_setting, :id, :name, :index_page_url, :index_page_css, :detail_page_title_css, :detail_page_content_css, :user_id, :created_at, :updated_at
json.url crawler_setting_url(crawler_setting, format: :json)
