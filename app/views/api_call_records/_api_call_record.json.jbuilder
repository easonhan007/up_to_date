json.extract! api_call_record, :id, :post_id, :post_target_id, :status_code, :log, :user_id, :created_at, :updated_at
json.url api_call_record_url(api_call_record, format: :json)
