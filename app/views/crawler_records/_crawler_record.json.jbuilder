json.extract! crawler_record, :id, :url_count, :success, :failed, :urls, :crawler_setting_id, :created_at, :updated_at
json.url crawler_record_url(crawler_record, format: :json)
